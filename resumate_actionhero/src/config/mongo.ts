import { Initializer, api } from "actionhero";
import mongoose from "mongoose";

export class MongodbInitializer extends Initializer {
  constructor() {
    super();
    this.name = "mongodb";
    this.loadPriority = 1000;
    this.startPriority = 1000;
    this.stopPriority = 1000;
  }

  async initialize() {
    api.mongodb = {
      connection: null,
      client: null,
    };
  }

  async start() {
    try {
      // Updated connection without deprecated options
      const connection = await mongoose.connect("mongodb://localhost:27017/your-database-name");
      
      api.mongodb.connection = connection;
      api.mongodb.client = mongoose;
      
      api.log("Connected to MongoDB", "info");
    } catch (error) {
      api.log("Error connecting to MongoDB:", "error", error);
      throw error;
    }
  }

  async stop() {
    if (api.mongodb.connection) {
      await mongoose.disconnect();
      api.log("Disconnected from MongoDB", "info");
    }
  }
}