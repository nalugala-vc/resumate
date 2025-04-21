// src/initializers/mongodb.ts
import { Initializer, api } from 'actionhero'
import mongoose from 'mongoose'

export class MongoDBInitializer extends Initializer {
  constructor() {
    super()
    this.name = 'mongodb'
    this.loadPriority = 1000
  }

  async initialize() {
    const mongoURI = process.env.MONGO_URI || 'mongodb://localhost:27017/actionheroApp'

    try {
      await mongoose.connect(mongoURI)
      api.log('✅ MongoDB connected successfully')
    } catch (error) {
      api.log('❌ MongoDB connection error:', 'error', error)
    }
  }

  async stop() {
    await mongoose.disconnect()
  }
}
