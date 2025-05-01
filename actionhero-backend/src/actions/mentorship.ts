import { Action, ActionProcessor } from 'actionhero';
import { Mentor } from '../models/Mentor';

export class AddMentor extends Action {
    constructor() {
      super();
      this.name = 'addMentor';
      this.description = 'Add a new mentor';
      this.inputs = {
        image: { required: true },
        name: { required: true },
        company: { required: true },
        jobRole: { required: true },
        about: { required: true },
        skills: {
            required: true,
            formatter: (param: string) => {

              if (Array.isArray(param)) return param;

              if (typeof param === 'string') return param.split(',').map((s) => s.trim());
           
              return [];
            },
            validator: (param: string | any[]) => Array.isArray(param) && param.length > 0,
          },
          
      };
    }
  
    async run(data: ActionProcessor<AddMentor>) {
      const { image, name, jobRole, about, skills, company } = data.params;
      console.log('Received skills:', skills); 
      
      const mentor = new Mentor({ image, name, jobRole, about, skills, company });
      await mentor.save();
      
      data.response.success = true;
      data.response.mentor = mentor;
    }
  }

export class FetchMentors extends Action {
    constructor() {
      super();
      this.name = 'fetchMentors';
      this.description = 'Fetch all mentors';
      this.inputs = {}; 
    }
  
    async run(data: ActionProcessor<FetchMentors>) {
      const mentors = await Mentor.find({});
      data.response.success = true;
      data.response.mentors = mentors;
    }
  }

export class DeleteMentor extends Action {
  constructor() {
    super();
    this.name = 'deleteMentor';
    this.description = 'Delete a mentor by ID';
    this.inputs = {
      mentorId: { required: true },
    };
  }

  async run(data: ActionProcessor<DeleteMentor>) {
    const { mentorId } = data.params;
    await Mentor.findByIdAndDelete(mentorId);
    data.response.success = true;
    data.response.message = 'Mentor deleted';
  }
}
