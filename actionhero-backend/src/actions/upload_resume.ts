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
    this.outputExample = this.outputExample = {
      overall_score: 75,
      structure: 78,
      language_clarity: 72,
      impact: 80,
      ats_compatibility: 69,
      details: {
        structure: {
          description: "The resume is well-structured and easy to follow, with clear headings and formatting. However, the summary could be more impactful.",
          recommendations: [
            {
              title: "Enhance the Summary Section",
              description: "Highlight top achievements and skills in depth to make the summary stand out."
            },
            {
              title: "Improve Formatting Consistency",
              description: "Ensure consistent use of bullet points, fonts, and spacing across all sections."
            },
            {
              title: "Use Clear Section Headings",
              description: "Ensure section headings like 'Experience' and 'Education' are bold and stand out for easy scanning."
            }
          ]
        },
        language_clarity: {
          description: "The language is mostly clear but could be more concise in some areas.",
          recommendations: [
            {
              title: "Simplify Complex Sentences",
              description: "Break down long sentences into simpler, more direct statements."
            },
            {
              title: "Avoid Repetition",
              description: "Eliminate repeated phrases and words to improve clarity."
            },
            {
              title: "Use Action Verbs",
              description: "Start bullet points with strong action verbs to make achievements more compelling."
            }
          ]
        },
        impact: {
          description: "The impact of experience is strong, but measurable results and metrics are missing.",
          recommendations: [
            {
              title: "Quantify Achievements",
              description: "Add numbers or percentages to show the impact of your work, such as 'increased sales by 20%'."
            },
            {
              title: "Focus on Key Achievements",
              description: "Highlight the most important achievements from each role, emphasizing your impact."
            },
            {
              title: "Use Strong Action Words",
              description: "Start bullet points with verbs like 'led', 'managed', or 'increased' to make your impact clearer."
            }
          ]
        },
        ats_compatibility: {
          description: "ATS compatibility is moderate due to lack of standard keywords.",
          recommendations: [
            {
              title: "Include Industry Keywords",
              description: "Incorporate relevant keywords from job descriptions to improve your chances with ATS systems."
            },
            {
              title: "Use Standard Job Titles",
              description: "Avoid using uncommon job titles that may not be recognized by ATS. Use industry-standard titles."
            },
            {
              title: "Optimize Resume Formatting",
              description: "Use standard resume formatting to ensure your resume is parsed correctly by ATS systems."
            }
          ]
        }
      }
    };
    ;
  }

  async run(data: { connection: any; response: any }) {
    try {
      // Get the resume text directly from the request data
      const { resume_text } = data.connection.params;

      if (!resume_text) {
        throw new Error("No resume text provided.");
      }

      // Modify the prompt to request detailed feedback and improvement steps
      const prompt = `
Analyze this resume and rate it out of 100 for job market optimization.
Provide ratings for: Structure, Language/Clarity, Impact of Experience, and ATS Compatibility.
For each category, provide:
1. A description of why the resume received the score for that category.
2. At least 3 detailed, actionable recommendations with a title and description for improvement.

PLEASE NOTE THAT OVERALL SCORE IS CALCULATED BY ADDING ALL THE 4 CATEGORIES AND DIVIDING BY 4.

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
    "structure": {
      "description": string,
      "recommendations": [
        {
          "title": string,
          "description": string
        },
        {
          "title": string,
          "description": string
        },
        {
          "title": string,
          "description": string
        }
      ]
    },
    "language_clarity": {
      "description": string,
      "recommendations": [
        {
          "title": string,
          "description": string
        },
        {
          "title": string,
          "description": string
        },
        {
          "title": string,
          "description": string
        }
      ]
    },
    "impact": {
      "description": string,
      "recommendations": [
        {
          "title": string,
          "description": string
        },
        {
          "title": string,
          "description": string
        },
        {
          "title": string,
          "description": string
        }
      ]
    },
    "ats_compatibility": {
      "description": string,
      "recommendations": [
        {
          "title": string,
          "description": string
        },
        {
          "title": string,
          "description": string
        },
        {
          "title": string,
          "description": string
        }
      ]
    }
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
      console.log("Raw Cohere response:", rawText.substring(0, 100) + "...");

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
