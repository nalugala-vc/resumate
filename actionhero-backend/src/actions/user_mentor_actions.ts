import { Action, ActionProcessor } from 'actionhero';
import { User } from '../models/User';

export class ToggleLikeMentor extends Action {
  constructor() {
    super();
    this.name = 'toggleLikeMentor';
    this.description = 'Toggle like/dislike for a mentor';
    this.inputs = {
      userId: { required: true },
      mentorId: { required: true },
      likeAction: { required: true }, 
    };
  }

  async run(data: ActionProcessor<ToggleLikeMentor>) {
    const { userId, mentorId, likeAction } = data.params;
    const mentorIdStr = mentorId.toString();
    
    const user = await User.findById(userId);
    if (!user) throw new Error('User not found');


    if (!user.likedMentors) user.likedMentors = [];
    if (!user.dislikedMentors) user.dislikedMentors = [];

    let message = '';

    switch (likeAction) {
      case 'like':
      
        user.dislikedMentors = user.dislikedMentors.filter(id => id !== mentorIdStr);
        
      
        if (!user.likedMentors.includes(mentorIdStr)) {
          user.likedMentors.push(mentorIdStr);
        }
        message = 'Mentor liked successfully';
        break;
        
      case 'dislike':
       
        user.likedMentors = user.likedMentors.filter(id => id !== mentorIdStr);
        
        
        if (!user.dislikedMentors.includes(mentorIdStr)) {
          user.dislikedMentors.push(mentorIdStr);
        }
        message = 'Mentor disliked successfully';
        break;
        
      case 'remove':
      
        user.likedMentors = user.likedMentors.filter(id => id !== mentorIdStr);
        user.dislikedMentors = user.dislikedMentors.filter(id => id !== mentorIdStr);
        message = 'Mentor removed from likes/dislikes';
        break;
        
      default:
        throw new Error('Invalid likeAction. Use "like", "dislike", or "remove"');
    }

    await user.save();
    
    data.response.success = true;
    data.response.message = message;
    data.response.likeStatus = {
      liked: user.likedMentors.includes(mentorIdStr),
      disliked: user.dislikedMentors.includes(mentorIdStr)
    };
  }
}

export class BookMentorSession extends Action {
  constructor() {
    super();
    this.name = 'bookMentorSession';
    this.description = 'User books a session with a mentor';
    this.inputs = {
      userId: { required: true },
      mentorId: { required: true },
      date: { required: true },
      time: { required: true },
    };
  }

  async run(data: ActionProcessor<BookMentorSession>) {
    const { userId, mentorId, date, time } = data.params;
    const user = await User.findById(userId);
    if (!user) throw new Error('User not found');

    user.bookedSessions = user.bookedSessions || [];
    user.bookedSessions.push({ 
      mentorId: mentorId.toString(), 
      date, 
      time 
    });
    
    await user.save();

    data.response.success = true;
    data.response.message = 'Session booked successfully';
  }
}