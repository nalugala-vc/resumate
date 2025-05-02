import { Action, ActionProcessor } from 'actionhero';
import { Company } from '../models/Company';

export class AddCompany extends Action {
  constructor() {
    super();
    this.name = 'addCompany';
    this.description = 'Add a new company';
    this.inputs = {
      name: { required: true },
      numberOfEmployees: { required: true },
      email: { required: true },
      phoneNumber: { required: true },
      description: { required: true },
    };
  }

  async run(data: ActionProcessor<AddCompany>) {
    const company = new Company(data.params);
    await company.save();

    data.response.success = true;
    data.response.company = company;
  }
}

export class DeleteCompany extends Action {
  constructor() {
    super();
    this.name = 'deleteCompany';
    this.description = 'Delete a company by ID';
    this.inputs = {
      companyId: { required: true },
    };
  }

  async run(data: ActionProcessor<DeleteCompany>) {
    await Company.findByIdAndDelete(data.params.companyId);
    data.response.success = true;
    data.response.message = 'Company deleted';
  }
}
