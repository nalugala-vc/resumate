import { Action, ActionProcessor } from 'actionhero';
import { User } from '../models/User';
import * as jwt from 'jsonwebtoken';
import * as nodemailer from 'nodemailer';

function generateOTP(): string {
  return Math.floor(100000 + Math.random() * 900000).toString(); 
}

async function sendOTPEmail(email: string, otp: string) {
  const transporter = nodemailer.createTransport({
    service: 'gmail', 
    auth: {
      user: 'vanessachebukwa@gmail.com',
      pass: process.env.GOOGLE_CODE,
    },
  });

  const mailOptions = {
    from: 'vanessachebukwa@gmail.com',
    to: email,
    subject: 'Your Resumate Verification Code',
    text: `Your verification code is: ${otp}`,
  };

  await transporter.sendMail(mailOptions);
}

export class Signup extends Action {
    constructor() {
      super();
      this.name = 'signup';
      this.description = 'Register a new user with OTP verification';
      this.inputs = {
        email: { required: true },
        password: { required: true },
        name: { required: true },
      };
    }
  
    async run(data: ActionProcessor<Signup>) {
      const { email, password,name } = data.params;
  
  
      const existing = await User.findOne({ email });
      if (existing) throw new Error('Email already exists');
  
      const otpCode = generateOTP();
      const otpExpiresAt = new Date(Date.now() + 10 * 60 * 1000); 
  
      const user = new User({ email, password, name,otpCode, otpExpiresAt ,});
      await user.save();
  
      try {
      
        await sendOTPEmail(email, otpCode);
      } catch (err) {
       
        console.error('❌ Failed to send OTP email:', err);
        throw new Error('Failed to send OTP email');
      }
  
     
      data.response.success = true;
      data.response.message = 'User created. OTP sent to email.';
    }
  }
  

export class Signin extends Action {
  constructor() {
    super();
    this.name = 'signin';
    this.description = 'Login user';
    this.inputs = {
      email: { required: true },
      password: { required: true },
    };
  }

  async run(data: ActionProcessor<Signin>) {
    const { params, response } = data;
    const { email, password } = params;
  
    const user = await User.findOne({ email });
    if (!user || !(await user.comparePassword(password))) {
      throw new Error('Invalid credentials');
    }
  
    const token = jwt.sign({ id: user._id, email: user.email }, process.env.JWT_SECRET, {
      expiresIn: '1d',
    });

    delete user.password;
    delete user.__v;

  
    response.success = true;
    response.token = token;
    response.user = user;
  }
  
}

export class VerifyOtp extends Action {
    constructor() {
      super();
      this.name = 'verifyOtp';
      this.description = 'Verify OTP and activate user';
      this.inputs = {
        email: { required: true },
        otpCode: { required: true },
      };
    }
  
    async run(data: ActionProcessor<VerifyOtp>) {
      const { email, otpCode } = data.params;
      const user = await User.findOne({ email });
  
      if (!user) throw new Error('User not found');
      if (user.isEmailVerified) throw new Error('User already verified');
      if (user.otpCode !== otpCode) throw new Error('Invalid OTP');
      if (user.otpExpiresAt < new Date()) throw new Error('OTP expired');
  
      user.isEmailVerified = true;
      user.otpCode = undefined;
      user.otpExpiresAt = undefined;
      await user.save();
  
      data.response.success = true;
      data.response.message = 'Email successfully verified!';
    }
  }
  
