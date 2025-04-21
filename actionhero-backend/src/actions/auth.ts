import { Action, ActionProcessor } from 'actionhero';
import { User } from '../models/User';
import * as jwt from 'jsonwebtoken';

const JWT_SECRET = 'yourSuperSecret';

export class Signup extends Action {
  constructor() {
    super();
    this.name = 'signup';
    this.description = 'Register a new user';
    this.inputs = {
      email: { required: true },
      password: { required: true },
    };
  }

  async run(data: ActionProcessor<Signup>) {
    const { params, response } = data;

    const { email, password } = params;

    const existing = await User.findOne({ email });
    if (existing) throw new Error('Email already exists');

    const user = new User({ email, password });
    await user.save();

    response.success = true;
    response.message = 'User created';
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

    const token = jwt.sign({ id: user._id, email: user.email }, JWT_SECRET, {
      expiresIn: '1d',
    });

    response.success = true;
    response.token = token;
  }
}
