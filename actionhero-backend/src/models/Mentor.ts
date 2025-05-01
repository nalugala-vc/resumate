import mongoose, { Document, Schema } from 'mongoose';

export interface IMentor extends Document {
  image: string;
  name: string;
  jobRole: string;
  company: string;
  about: string;
  skills: string[];
}

const MentorSchema: Schema<IMentor> = new Schema({
  image: { type: String, required: true },
  name: { type: String, required: true },
  company: { type: String, required: true },
  jobRole: { type: String, required: true },
  about: { type: String, required: true },
  skills: [{ type: String, required: true }],
});

export const Mentor = mongoose.model<IMentor>('Mentor', MentorSchema);
