// src/initializers/resume_upload.ts
import { Initializer, log } from "actionhero";
import * as path from "path";
import * as fs from "fs-extra";

export class ResumeUploadInitializer extends Initializer {
  constructor() {
    super();
    this.name = "resumeUpload";
    this.loadPriority = 1000;
    this.startPriority = 1000;
    this.stopPriority = 1000;
  }

  async initialize() {

    const uploadDir = path.join(process.cwd(), "uploads");
    if (!fs.existsSync(uploadDir)) {
      fs.mkdirSync(uploadDir);
    }
    
  
    log("Resume upload system initialized", "info");
  }

  async start() {}
  async stop() {}
}