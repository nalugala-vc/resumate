import mongoose, { Document, Schema } from 'mongoose';
import * as bcrypt from 'bcrypt';

export interface IUser extends Document {
  email: string;
  password: string;
  name: string;
  isEmailVerified: boolean;
  otpCode?: string;
  otpExpiresAt?: Date;
  likedMentors: string[]; 
  dislikedMentors: string[]; 
  bookedSessions?: {
    mentorId: string;
    date: string;
    time: string;
  }[];
  comparePassword(password: string): Promise<boolean>;
}

const UserSchema: Schema<IUser> = new Schema({
  email: { type: String, required: true, unique: true },
  password: { type: String, required: true },
  name: { type: String, required: true },
  isEmailVerified: { type: Boolean, default: false },
  otpCode: { type: String }, 
  otpExpiresAt: { type: Date }, 
  likedMentors: [{ type: String, ref: 'Mentor' }], 
  dislikedMentors: [{ type: String, ref: 'Mentor' }], 
  bookedSessions: [{
    mentorId: { type: Schema.Types.ObjectId, ref: 'Mentor', required: true },
    date: { type: String, required: true },
    time: { type: String, required: true },
  }],
});

// Hash password before saving if it's new/modified
UserSchema.pre<IUser>('save', async function (next) {
  if (!this.isModified('password')) return next();
  this.password = await bcrypt.hash(this.password, 10);
  next();
});

UserSchema.methods.comparePassword = async function (password: string) {
  return bcrypt.compare(password, this.password);
};

export const User = mongoose.model<IUser>('User', UserSchema);
