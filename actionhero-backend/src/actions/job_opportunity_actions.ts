import { Action, ActionProcessor } from 'actionhero';
import { JobOpportunity } from '../models/JobOpportunities';
import { User } from '../models/User';

export class AddJobOpportunity extends Action {
  constructor() {
    super();
    this.name = 'addJobOpportunity';
    this.description = 'Add a new job';
    this.inputs = {
      company: { required: true },
      image: { required: true },
      title: { required: true },
      description: { required: true },
      type: { required: true },
      category: { required: true },
      mode: { required: true },
      expiryDate: { required: true },
      responsibilities: {
        required: true,
        formatter: (param: string) => {
          if (Array.isArray(param)) return param;
          return param.split('||').map((s) => s.trim());
        },
        validator: (param: string | any[]) => Array.isArray(param) && param.length > 0,
      },
    };
  }

  async run(data: ActionProcessor<AddJobOpportunity>) {
    const job = new JobOpportunity({ ...data.params, applicants: 0 });
    await job.save();
    data.response.success = true;
    data.response.job = job;
  }
}

export class GetAllJobOpportunities extends Action {
    constructor() {
      super();
      this.name = 'getAllJobOpportunities';
      this.description = 'Fetch all job opportunities including company details';
      this.inputs = {};
    }
  
    async run(data: ActionProcessor<GetAllJobOpportunities>) {
      const jobs = await JobOpportunity.find().populate('company');
      data.response.success = true;
      data.response.jobs = jobs;
    }
  }
  

export class DeleteJobOpportunity extends Action {
  constructor() {
    super();
    this.name = 'deleteJobOpportunity';
    this.description = 'Delete a job opportunity by ID';
    this.inputs = {
      jobId: { required: true },
    };
  }

  async run(data: ActionProcessor<DeleteJobOpportunity>) {
    await JobOpportunity.findByIdAndDelete(data.params.jobId);
    data.response.success = true;
    data.response.message = 'Job deleted';
  }
}

export class ApplyForJob extends Action {
    constructor() {
      super();
      this.name = 'applyForJob';
      this.description = 'Allows a user to apply for a job once only';
      this.inputs = {
        jobId: { required: true },
        userId: { required: true },
      };
    }
    async run(data: ActionProcessor<ApplyForJob>) {

      const { jobId, userId } = data.params;
  
      const user = await User.findById(userId);
      if (!user) throw new Error('User not found');
  
      const job = await JobOpportunity.findById(jobId);
      if (!job) throw new Error('Job not found');

      const alreadyApplied = user.appliedJobs.some((job) =>
        job.jobId.toString() === jobId
      );
  
      if (alreadyApplied) {
        data.response.success = false;
        data.response.message = 'User has already applied for this job';
        return;
      }
  
    
      user.appliedJobs.push({ jobId, appliedAt: new Date() });

      await user.save();
  
    
      job.applicants = (job.applicants || 0) + 1;
      await job.save();
  
      data.response.success = true;
      data.response.message = 'Job application submitted successfully';
      data.response.user = user;
    }
  }
