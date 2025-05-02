import mongoose, { Document, Schema, Types } from 'mongoose';

export interface IJobOpportunity extends Document {
    company: Types.ObjectId;
  image: string;
  title: string;
  description: string;
  type: 'Full-time' | 'Part-time' | 'Contract';
  mode: 'Remote' | 'Hybrid' | 'On-site';
  expiryDate: Date;
  applicants: number;
  responsibilities: string[];
  category: 'frontend' | 'backend'| 'machine learning';
}

const JobOpportunitySchema: Schema<IJobOpportunity> = new Schema({
  company: { type: Schema.Types.ObjectId, ref: 'Company', required: true },
  image: { type: String, required: true },
  title: { type: String, required: true },
  description: { type: String, required: true },
  type: {
    type: String,
    enum: ['Full-time', 'Part-time', 'Contract'],
    required: true,
  },
  mode: {
    type: String,
    enum: ['Remote', 'Hybrid', 'On-site'],
    required: true,
  },
  expiryDate: { type: Date, required: true },
  applicants: { type: Number, default: 0 },
  responsibilities: [{ type: String, required: true }],
  category: { type: String, enum: ['frontend', 'backend', 'machine learning'], required: true }
});

export const JobOpportunity = mongoose.model<IJobOpportunity>('JobOpportunity', JobOpportunitySchema);
