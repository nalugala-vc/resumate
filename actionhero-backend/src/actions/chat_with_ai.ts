import { Action, api } from "actionhero";
import { CohereClient } from "cohere-ai";

// Setup Cohere
const cohere = new CohereClient({
  token: process.env.COHERE_TOKEN 
});

export class ChatWithAI extends Action {
  constructor() {
    super();
    this.name = "chatWithAI";
    this.description = "Send a message to the AI and get a chat response";
    this.inputs = {
      message: { required: true },
      chatHistory: { required: false }, // Optional for memory
    };
    this.outputExample = {
      reply: "Hello! How can I help you today?",
    };
  }

  async run(data: { connection: any; response: any }) {
    const { message, chatHistory } = data.connection.params;
  
    if (!message || message.trim() === "") {
      throw new Error("Message cannot be empty.");
    }
  
    try {
      const stream = await cohere.chatStream({
        model: "command",
        message,
        temperature: 0.6,
        chatHistory: chatHistory || [],
      });
  
      let fullResponse = "";
  
      for await (const chat of stream) {
        if (chat.eventType === "text-generation") {
          fullResponse += chat.text;
        }
      }
  
      data.response.reply = fullResponse || "No response from AI.";
    } catch (err) {
      api.log("Cohere chatStream error: " + err.message, "error");
      throw new Error("Failed to get response from AI.");
    }
  }
  
  
}
