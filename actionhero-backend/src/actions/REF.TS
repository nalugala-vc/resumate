// src/actions/uploadResume.ts
import { Action } from "actionhero";
import { IncomingForm } from "formidable";
import * as fs from "fs-extra";
import { CohereClient } from "cohere-ai";
import * as path from "path";

// Initialize Cohere client
const cohere = new CohereClient({
  token: "fJwZnBfOXnuaATnzma2cKr6lOmwa7U4WG5Y7tr93", // Use env var in production
});

// Maximum size we'll send to Cohere (they have a token limit)
const MAX_TEXT_LENGTH = 2000; // Reduced even further for testing

export class UploadResume extends Action {
  constructor() {
    super();
    this.name = "uploadResume";
    this.description = "Upload a resume and analyze it using Cohere";
    this.inputs = {};
    this.outputExample = {
      analysis: {
        overall_score: 75,
        structure: 78,
        language_clarity: 72,
        impact: 80,
        ats_compatibility: 69,
      },
      feedback: "Detailed feedback text here...",
    };
  }

  async run(data: { connection: any; response: any }) {
    console.log('Starting uploadResume action...');
    const req = data.connection.rawConnection.req;
    const res = data.connection.rawConnection.res;

    console.log('Incoming request headers:', req.headers);
console.log('Method:', req.method);

    
    // Ensure upload directory exists
    const uploadDir = path.join(process.cwd(), "uploads");
    console.log(`Upload directory: ${uploadDir}`);
    
    try {
      if (!fs.existsSync(uploadDir)) {
        console.log('Creating upload directory...');
        fs.mkdirSync(uploadDir, { recursive: true });
      }
    } catch (dirError) {
      console.error('Failed to create upload directory:', dirError);
      return { error: true, message: "Failed to create upload directory" };
    }
    
    // Configure formidable with explicit options
    const form = new IncomingForm({ 
      keepExtensions: true, 
      maxFileSize: 5 * 1024 * 1024, // 5MB limit
      uploadDir, // Specify upload directory
      multiples: false // We only expect one file
    });
    
    console.log('Parsing form data...');
    
    try {
      // Parse form data with explicit logging for debugging
      const { files } = await new Promise<any>((resolve, reject) => {
        form.parse(req, (err, fields, files) => {
          console.log('Form parse callback executed');
          if (err) {
            console.error('Form parse error:', err);
            return reject(err);
          }
          console.log(`Parsed files: ${files ? Object.keys(files).join(', ') : 'none'}`);
          resolve({ fields, files });
        });
      });
      
      console.log('Form data parsed successfully');

      // Check if we have a resume file
      const resumeFileInput = files?.resume;
      if (!resumeFileInput) {
        console.error('No resume file found in upload');
        return { error: true, message: "No resume file uploaded" };
      }
      
      const resumeFile = Array.isArray(resumeFileInput) ? resumeFileInput[0] : resumeFileInput;
      console.log(`Resume file path: ${resumeFile.filepath}`);

      // Read the resume text
      console.log('Reading file content...');
      let resumeText;
      try {
        resumeText = await fs.readFile(resumeFile.filepath, "utf-8");
        console.log(`Read ${resumeText.length} characters from file`);
      } catch (readError) {
        console.error('Error reading file:', readError);
        return { error: true, message: "Failed to read uploaded file" };
      }
      
      // Truncate text if needed to prevent token limit issues
      const truncatedText = resumeText.length > MAX_TEXT_LENGTH 
        ? resumeText.substring(0, MAX_TEXT_LENGTH) + "... (truncated)" 
        : resumeText;
      
      console.log(`Resume text length after truncation: ${truncatedText.length}`);

      // For testing, use a simpler resume if the actual one is causing issues
      const prompt = `
Analyze this resume and rate it out of 100 for job market optimization.
Provide ratings for: Structure, Language/Clarity, Impact of Experience, and ATS Compatibility.

Resume text:
${truncatedText}

Return ONLY valid JSON in this format:
{
  "overall_score": number,
  "structure": number,
  "language_clarity": number,
  "impact": number,
  "ats_compatibility": number
}
`;

      console.log("Sending request to Cohere...");
      console.time("cohere-request");

      // Use a direct approach instead of Promise.race for better clarity
      let cohereResponse;
      
      try {
        // Set a timeout that we can clear
        const timeoutId = setTimeout(() => {
          console.log("Cohere request is taking too long - forcing timeout");
          throw new Error("Cohere request timed out after 25 seconds");
        }, 25000); // 25 second timeout
        
        // Make the Cohere request directly
        cohereResponse = await cohere.chat({
          model: "command-light", // Try the light model for faster response
          message: prompt,
      
        });
        
        // Clear timeout since we got a response
        clearTimeout(timeoutId);
        
        console.timeEnd("cohere-request");
        console.log("Cohere request completed successfully");
      
      } catch (cohereError) {
        console.timeEnd("cohere-request");
        console.error("Cohere API error:", cohereError);
        
        // Clean up the uploaded file on error
        try {
          await fs.unlink(resumeFile.filepath);
        } catch (cleanupError) {
          console.error("Failed to clean up temp file:", cleanupError);
        }
        
        // Return friendly error
        if (cohereError.message.includes("timed out")) {
          return {
            error: true,
            message: "The AI service is taking too long to respond. Please try again later with a shorter resume."
          };
        }
        
        return {
          error: true,
          message: "Error getting analysis from AI service: " + cohereError.message
        };
      }

      // Clean up the uploaded file
      console.log("Cleaning up temporary file...");
      try {
        await fs.unlink(resumeFile.filepath);
        console.log("Temporary file deleted");
      } catch (cleanupError) {
        console.error("Failed to clean up temp file:", cleanupError);
      }

      // Process the response
      const rawText = cohereResponse.text ?? "";
      console.log("Raw Cohere response received, length:", rawText.length);
      console.log("Response sample:", rawText.substring(0, 100));

      try {
        // Extract JSON portion from the response
        const jsonMatch = rawText.match(/\{[\s\S]*?\}/);
        let analysisResult = {};
        let feedbackText = "";
        
        if (jsonMatch) {
          console.log("JSON match found in response");
          analysisResult = JSON.parse(jsonMatch[0]);
          console.log("Analysis parsed:", analysisResult);
          
          // Extract the narrative feedback (everything after the JSON)
          const textParts = rawText.split(/\}[\s\n]*/);
          if (textParts.length > 1) {
            feedbackText = textParts.slice(1).join("").trim();
            console.log("Feedback extracted, length:", feedbackText.length);
          }
        } else {
          console.log("No JSON found in response, using full text as feedback");
          feedbackText = rawText;
        }

        // Return both the analysis scores and the feedback
        console.log("Returning successful response");
        return {
          analysis: analysisResult,
          feedback: feedbackText
        };
      } catch (parseError) {
        console.error("Failed to parse AI response:", parseError);
        return {
          error: true,
          message: "Failed to parse AI response",
          rawResponse: rawText.substring(0, 500) // Send partial raw response for debugging
        };
      }
    } catch (error) {
      console.error("Error in uploadResume action:", error);
      // Return error in a format that will be useful to the client
      return {
        error: true,
        message: error.message || "An unknown error occurred"
      };
    }
  }
}