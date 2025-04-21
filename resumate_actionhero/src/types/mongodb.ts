export interface MongoConfig {
    url: string;
    options: {
      useNewUrlParser: boolean;
      useUnifiedTopology: boolean;
      [key: string]: any;
    };
    connectionRetries?: number;
    retryDelay?: number;
  }
  