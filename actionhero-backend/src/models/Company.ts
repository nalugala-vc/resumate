import mongoose, { Document, Schema } from 'mongoose';
import { IJobOpportunity } from './JobOpportunities'

export interface ICompany extends Document {
  name: string;
  numberOfEmployees: number;
  email: string;
  phoneNumber: string;
  description: string;
  jobOpportunities?: IJobOpportunity[];
}

const CompanySchema: Schema<ICompany> = new Schema({
  name: { type: String, required: true },
  numberOfEmployees: { type: Number, required: true },
  email: { type: String, required: true },
  phoneNumber: { type: String, required: true },
  description: { type: String, required: true },
});

export const Company = mongoose.model<ICompany>('Company', CompanySchema);
