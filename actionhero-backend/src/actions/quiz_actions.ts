import { Action, ActionProcessor } from 'actionhero';
import { User } from '../models/User';
import * as jwt from 'jsonwebtoken';
import { JwtPayload } from 'jsonwebtoken';

const JWT_SECRET = 'yourSuperSecret';

export class SaveQuizResults extends Action {
  constructor() {
    super();
    this.name = 'saveQuizResults';
    this.description = 'Save quiz results to user profile';
    this.inputs = {
        token: { required: true },
        results: { required: true },
        topCategory: { required: true },
        level: { required: true },
        recommendations: {
          required: true,
          formatter: (param: string) => {
            if (Array.isArray(param)) return param;
            if (typeof param === 'string') return param.split('||').map((s) => s.trim());
            return [];
          },
          validator: (param: string | any[]) => Array.isArray(param) && param.length > 0,
        },
        categoryNames: { required: true },
        selectedAnswers: {
          required: true,
          validator: (param: any) => typeof param === 'object' && param !== null,
        },
      };
      
  }

  async run(data: ActionProcessor<SaveQuizResults>) {
    const {
      token,
      results,
      topCategory,
      level,
      recommendations,
      categoryNames,
      selectedAnswers,
    } = data.params;
  
    let userId;
    try {
      const decoded = jwt.verify(token, JWT_SECRET);
      if (typeof decoded === 'string') {
        throw new Error('Invalid token payload');
      } else {
        userId = (decoded as JwtPayload).id;
      }
    } catch {
      throw new Error('Invalid token');
    }
  
    const user = await User.findById(userId);
    if (!user) throw new Error('User not found');
  
    user.quizResults = {
      results,
      topCategory,
      level,
      recommendations,
      categoryNames,
      selectedAnswers, 
    };
  
    await user.save();
  
    data.response.success = true;
    data.response.message = 'Quiz results saved';
    data.response.user = user;

    
  }
  
}
export class GetQuizResults extends Action {
    constructor() {
      super();
      this.name = 'getQuizResults';
      this.description = 'Get saved quiz results for a user';
      this.inputs = {
        token: { required: true },
      };
    }
  
    async run(data: ActionProcessor<GetQuizResults>) {
      const { token } = data.params;
  
      let userId;
      try {
        const decoded = jwt.verify(token, JWT_SECRET);
        

let userId: string;
if (typeof decoded === 'string') {
  throw new Error('Invalid token payload');
} else {
  userId = (decoded as JwtPayload).id;
}
      } catch {
        throw new Error('Invalid token');
      }
  
      const user = await User.findById(userId);
      if (!user || !user.quizResults) {
        data.response.success = true;
        data.response.hasResults = false;
        return;
      }
  
      data.response.success = true;
      data.response.hasResults = true;
      data.response.quizResults = user.quizResults;
    }
  }
  