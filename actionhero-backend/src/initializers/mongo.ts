import { Initializer, log } from 'actionhero';
import mongoose from 'mongoose';

export class MongoInitializer extends Initializer {
  constructor() {
    super();
    this.name = 'mongo';
  }

  async initialize() {
    const uri = process.env.MONGODB_URI;

    try {
      await mongoose.connect(uri);
      log('✅ Connected to MongoDB', 'info');
    } catch (err) {
      log('❌ MongoDB connection failed: ' + err, 'error');
    }
  }
}
