import * as path from "path";
import * as fs from "fs";
import { PackageJson } from "type-fest";
import { ActionheroLogLevel } from "actionhero";

const namespace = "general";

declare module "actionhero" {
  export interface ActionheroConfigInterface {
    [namespace]: ReturnType<(typeof DEFAULT)[typeof namespace]>;
  }
}

export const DEFAULT = {
  [namespace]: () => {
    const packageJSON: PackageJson = JSON.parse(
      fs
        .readFileSync(path.join(__dirname, "..", "..", "package.json"))
        .toString(),
    );

    return {
      apiVersion: packageJSON.version,
      serverName: packageJSON.name,
      id: undefined as string,
      welcomeMessage: `Welcome to the ${packageJSON.name} api`,
      serverToken: "change-me",
      cachePrefix: "actionhero:cache:",
      lockPrefix: "actionhero:lock:",
      lockDuration: 1000 * 10,
      simultaneousActions: 5,
      enforceConnectionProperties: true,
      disableParamScrubbing: false,
      enableResponseLogging: false,
      filteredParams: [] as string[] | (() => string[]),
      filteredResponse: [] as string[] | (() => string[]),
      missingParamChecks: [null, "", undefined],
      directoryFileType: "index.html",
      fileRequestLogLevel: "info" as ActionheroLogLevel,
      defaultMiddlewarePriority: 100,
      channel: "actionhero",
      rpcTimeout: 5000,
      cliIncludeInternal: true,
      paths: {
        action: [path.join(__dirname, "..", "actions")],
        task: [path.join(__dirname, "..", "tasks")],
        server: [path.join(__dirname, "..", "servers")],
        cli: [path.join(__dirname, "..", "bin")],
        initializer: [path.join(__dirname, "..", "initializers")],
        public: [path.join(process.cwd(), "public")],
        pid: [path.join(process.cwd(), "pids")],
        log: [path.join(process.cwd(), "log")],
        plugin: [path.join(process.cwd(), "node_modules")],
        test: [path.join(process.cwd(), "__tests__")],
        src: path.join(process.cwd(), "src"),
        dist: path.join(process.cwd(), "dist"),
      },
      startingChatRooms: {
        // format is {roomName: {authKey, authValue}}
        // 'secureRoom': {authorized: true},
      } as Record<string, Record<string, any>>,
      secret: process.env.JWT_SECRET || 'your-super-secret-key', // THIS LINE IS CRITICAL
    };
  },
};

export const test = {
  [namespace]: () => {
    return {
      serverToken: `serverToken-${process.env.JEST_WORKER_ID || 0}`,
      startingChatRooms: {
        defaultRoom: {},
        otherRoom: {},
      },
      rpcTimeout: 3000,
    };
  },
};

export const production = {
  [namespace]: () => {
    return {
      fileRequestLogLevel: "debug",
    };
  },
};