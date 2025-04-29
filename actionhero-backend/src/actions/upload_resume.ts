import { Action, api } from "actionhero";
import { CohereClient } from "cohere-ai";

// Initialize Cohere client
const cohere = new CohereClient({
  token: "fJwZnBfOXnuaATnzma2cKr6lOmwa7U4WG5Y7tr93", // Replace with your real key
});

export class UploadResume extends Action {
  constructor() {
    super();
    this.name = "uploadResume";
    this.description = "Upload a resume as plain text and analyze it using Cohere";
    this.inputs = {
      resume_text: { required: true },
    };
    this.outputExample = {
      overall_score: 75,
      structure: 78,
      language_clarity: 72,
      impact: 80,
      ats_compatibility: 69,
      details: {

        structure: "The structure is clear, but the sections need better headers.",
        language_clarity: "The language is mostly clear but could be more concise.",
        impact: "The impact of experience is highlighted well but lacks measurable outcomes.",
        ats_compatibility: "ATS compatibility is moderate due to lack of standard keywords.",
      },
    };
  }

  async run(data: { connection: any; response: any }) {
    try {
      // Get the resume text directly from the request data
      const { resume_text } = data.connection.params;

      if (!resume_text) {
        throw new Error("No resume text provided.");
      }

      // Modify the prompt to request a breakdown with details
      const prompt = `
Analyze this resume and rate it out of 100 for job market optimization.
Provide ratings for: Structure, Language/Clarity, Impact of Experience, and ATS Compatibility.
Also, provide detailed feedback for each category, explaining why the resume received this score and areas for improvement.

Resume text:
${resume_text.substring(0, 4000)} ${resume_text.length > 4000 ? "... (truncated)" : ""}

Return ONLY valid JSON in this format:
{
  "overall_score": number,
  "structure": number,
  "language_clarity": number,
  "impact": number,
  "ats_compatibility": number,
  "details": {
    "structure": string,
    "language_clarity": string,
    "impact": string,
    "ats_compatibility": string
  }
}
      `;

      console.log("Sending request to Cohere...");
      console.time("cohere-request");

      const timeoutPromise = new Promise((_, reject) =>
        setTimeout(() => reject(new Error("Cohere request timed out after 60 seconds")), 60000)
      );

      const coherePromise = cohere.chat({
        model: "command", // You could also use "command-light" or "command-r"
        message: prompt,
        temperature: 0.3,
      });

      const completion = await Promise.race([coherePromise, timeoutPromise]) as any;
      console.timeEnd("cohere-request");

      const rawText = completion.text ?? "";
      console.log("Raw Cohere response:", rawText);

      try {
        // Check if the response is a valid JSON string
        const jsonMatch = rawText.match(/\{[\s\S]*\}/); // Find any JSON object
        const jsonStr = jsonMatch ? jsonMatch[0] : null;

        if (jsonStr) {
          // Try parsing the JSON response
          const result = JSON.parse(jsonStr);
          console.log("Successfully parsed result:", result);
          return result;
        } else {
          // If no JSON object found, handle it as plain text
          console.error("Failed to find JSON in AI response, returning raw text.");
          return { message: rawText };  // Return plain text as the response
        }
      } catch (parseError) {
        console.error("Failed to parse AI response:", parseError);
        throw new Error("Failed to parse AI response. Raw output: " + rawText);
      }
    } catch (error) {
      console.error("Error in uploadResume action:", error);
      throw error;
    }
  }
}
