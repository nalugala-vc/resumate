import { RoutesConfig } from "actionhero";

const namespace = "routes";

declare module "actionhero" {
  export interface ActionheroConfigInterface {
    [namespace]: ReturnType<(typeof DEFAULT)[typeof namespace]>;
  }
}

export const DEFAULT: { [namespace]: () => RoutesConfig } = {
  [namespace]: () => {
    return {
      get: [
        { path: "/status", action: "status" },
        { path: "/swagger", action: "swagger" },
        { path: '/verify-email', action: 'verify-email' },
        { path: "/createChatRoom", action: "createChatRoom" },
        { path: "/fetchMentors", action: "fetchMentors" },
        { path: '/getAllJobOpportunities', action: 'getAllJobOpportunities'},
      ],
      post :[
        { path: '/signup', action: 'signup'},
        { path: '/chatWithAI', action: 'chatWithAI'},
        { path: '/uploadResume', action: 'uploadResume'},
        { path: '/verify-otp', action: 'verifyOtp' },
        { path: '/signin', action: 'signin'},
        { path: '/addMentor', action: 'addMentor'},
        { path: '/toggleLikeMentor', action: 'toggleLikeMentor'},
        { path: '/bookMentorSession', action: 'bookMentorSession'},
   
        { path: '/addCompany', action: 'addCompany'},
        { path: '/getQuizResults', action: 'getQuizResults'},
       
        { path: '/addJobOpportunity', action: 'addJobOpportunity'},
        { path: '/applyForJob', action: 'applyForJob'},
        { path: '/saveQuizResults', action: 'saveQuizResults'},
      
      ],
      delete : [
        { path: '/deleteCompany', action: 'deleteCompany'},
      
        { path: '/deleteJobOpportunity', action: 'deleteJobOpportunity'},
        { path: '/deleteMentor', action: 'deleteMentor'},

      ]

      /* ---------------------
      For web clients (http and https) you can define an optional RESTful mapping to help route requests to actions.
      If the client doesn't specify and action in a param, and the base route isn't a named action, the action will attempt to be discerned from this routes.js file.

      Learn more here: https://www.actionherojs.com/tutorials/web-server#Routes

      examples:

      get: [
        { path: '/users', action: 'usersList' }, // (GET) /api/users
        { path: '/search/:term/limit/:limit/offset/:offset', action: 'search' }, // (GET) /api/search/car/limit/10/offset/100
      ],

      post: [
        { path: '/login/:userID(^\\d{3}$)', action: 'login' } // (POST) /api/login/123
      ],

      all: [
        { path: '/user/:userID', action: 'user', matchTrailingPathParts: true } // (*) /api/user/123, api/user/123/stuff
      ]

      ---------------------- */
    };
  },
};
