import mongoose, { Document, Schema } from 'mongoose';

export interface IChatMessage extends Document {
  userId: string;
  role: 'User' | 'AI';
  message: string;
  timestamp: Date;
}

const ChatMessageSchema: Schema<IChatMessage> = new Schema({
  userId: { type: String, required: true },
  role: { type: String, enum: ['User', 'AI'], required: true },
  message: { type: String, required: true },
  timestamp: { type: Date, default: Date.now },
});

export const ChatMessage = mongoose.model<IChatMessage>('ChatMessage', ChatMessageSchema);
