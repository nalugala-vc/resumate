import { Action, ActionProcessor } from 'actionhero';
import { JobOpportunity } from '../models/JobOpportunities';

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
