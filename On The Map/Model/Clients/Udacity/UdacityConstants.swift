//
//  Constants.swift
//  SleepingInTheLibrary
//
//  Created by Jarrod Parkes on 11/5/15.
//  Copyright © 2015 Udacity. All rights reserved.
//

// MARK: - Constants
extension UdacityClient{
    
    struct Constants {
        static let AppId = "QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr"
        static let APIKey = "QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY"
        static let APIScheme = "https"
        static let APIHost = "www.udacity.com"
        static let APIPath = "/api"
        static let ParseAPIHost = "www.parse.udacity.com"
        static let ParseAPIPath = "/parse"
        static let InvalidCredentialsCode = 403
    }
    
    // MARK: Methods
    struct Methods {
        
        // MARK: Account
        static let Account = "/users/{user_id}"
        
        // MARK: Authentication
        static let AuthenticationTokenNew = "/authentication/token/new"
        static let AuthenticationSessionNew = "/session"
        
        // MARK: Config
        static let Config = "/configuration"
        
    }
    
    // MARK: URL Keys
    struct URLKeys {
        static let UserID = "user_id"
    }
    
    // MARK: Parameter Keys
    struct ParameterKeys {
        static let SessionID = "session_id"
        static let Username = "username"
        static let UserID = "user_id"
        static let Password = "password"
        static let RequestToken = "request_token"
        static let Query = "query"
        static let AppId = "X-Parse-Application-Id"
        static let APIKey = "X-Parse-REST-API-Key"
    }
    
    // MARK: JSON Body Keys
    struct JSONBodyKeys {
        
    }
    
    // MARK: JSON Response Keys
    struct JSONResponseKeys {
        
        // MARK: General
        static let StatusMessage = "status_message"
        static let StatusCode = "status_code"
        
        // MARK: Authorization
        static let RequestToken = "request_token"
        static let SessionID = "id"
        static let Session = "session"
        
        // MARK: Account
        static let UserAccount = "account"
        static let UserID = "key"
        
        //MARK: User
        static let User = "user"
        static let LastName = "last_name"
        static let FirstName = "first_name"
        
    }
}
