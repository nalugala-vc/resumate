import mongoose from "mongoose";

declare module "actionhero" {
  export interface Api {
    mongodb: {
      connection: typeof mongoose | null;
      client: typeof mongoose | null;
    };
  }
}