import mongoose, { Document, Schema } from 'mongoose';

export interface ISession extends Document {
  userId: mongoose.Types.ObjectId;
  mentorId: mongoose.Types.ObjectId;
  date: Date;
  timeSlot: string;
  status: 'pending' | 'confirmed' | 'cancelled' | 'completed';
  notes?: string;
  createdAt: Date;
  updatedAt: Date;
}

const SessionSchema: Schema<ISession> = new Schema({
  userId: { 
    type: Schema.Types.ObjectId, 
    ref: 'User',
    required: true
  },
  mentorId: { 
    type: Schema.Types.ObjectId, 
    ref: 'Mentor',
    required: true
  },
  date: { 
    type: Date, 
    required: true 
  },
  timeSlot: { 
    type: String, 
    required: true 
  },
  status: { 
    type: String, 
    enum: ['pending', 'confirmed', 'cancelled', 'completed'],
    default: 'pending'
  },
  notes: { 
    type: String 
  }
}, { 
  timestamps: true 
});

// Create compound index for preventing double bookings
SessionSchema.index({ mentorId: 1, date: 1, timeSlot: 1 }, { unique: true });

export const Session = mongoose.model<ISession>('Session', SessionSchema);