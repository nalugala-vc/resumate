import { Initializer, log } from 'actionhero';
import mongoose from 'mongoose';

export class MongoInitializer extends Initializer {
  constructor() {
    super();
    this.name = 'mongo';
  }

  async initialize() {
    const uri = 'mongodb://localhost:27017/resumate';

    try {
      await mongoose.connect(uri);
      log('✅ Connected to MongoDB', 'info');
    } catch (err) {
      log('❌ MongoDB connection failed: ' + err, 'error');
    }
  }
}
