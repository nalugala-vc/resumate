// test-cohere.ts
import { CohereClient } from "cohere-ai";

const cohere = new CohereClient({
  token: "fJwZnBfOXnuaATnzma2cKr6lOmwa7U4WG5Y7tr93", // Replace with your real Cohere API key
});

async function testCohere() {
  try {
    console.log("Starting Cohere API test...");
    console.time("cohere-request");

    const chat = await cohere.chat({
      model: "command", // "command" is their general-purpose model
      message: `
Analyze this resume and rate it out of 100 for job market optimization.
Provide ratings for: Structure, Language/Clarity, Impact of Experience, and ATS Compatibility.

Resume text:
John Doe
📍 123 Maple Street, Springfield, IL
📞 (123) 456-7890 | ✉️ john.doe@email.com | 🌐 linkedin.com/in/johndoe

Professional Summary
Detail-oriented software developer with 3+ years of experience building full-stack web applications. Passionate about clean code, scalable architecture, and delivering impactful user experiences. Proficient in JavaScript, React, Node.js, and Python.

Skills
Languages: JavaScript, Python, TypeScript, SQL

Frameworks: React, Node.js, Express, Django

Tools: Git, Docker, AWS, Jest

Soft Skills: Communication, teamwork, problem-solving

Experience
Full-Stack Developer
Tech Solutions Inc. – Chicago, IL
Jan 2022 – Present

Designed and developed a CRM system using React and Node.js, reducing client churn by 15%

Led migration from REST APIs to GraphQL, improving data efficiency by 25%

Collaborated with a team of 5 engineers in Agile sprints

Junior Web Developer
Bright Apps Co. – Springfield, IL
Aug 2020 – Dec 2021

Built responsive UIs using HTML/CSS and React

Maintained REST APIs and implemented new features using Express

Wrote unit and integration tests to improve code coverage to 85%

Education
BSc in Computer Science
University of Illinois – Urbana-Champaign
2016 – 2020

Certifications
AWS Certified Developer – Associate

JavaScript Algorithms and Data Structures – freeCodeCamp



Return ONLY valid JSON in this format:
{
  "overall_score": number,
  "structure": number,
  "language_clarity": number,
  "impact": number,
  "ats_compatibility": number
}
      `
    });

    console.timeEnd("cohere-request");

    console.log("Cohere Response:", chat.text); // Cohere puts result in `text`
    console.log("Full response object:", JSON.stringify(chat, null, 2));

    return "Cohere API test completed successfully!";
  } catch (error) {
    console.error("Error testing Cohere API:", error);
    return `Cohere API test failed: ${error.message}`;
  }
}

testCohere().then(console.log).catch(console.error);
