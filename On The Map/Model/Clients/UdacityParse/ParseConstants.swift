//
//  ParseConstants.swift
//  On The Map
//
//  Created by Octavius on 11/6/17.
//  Copyright © 2017 Delfyette Designs. All rights reserved.
//

import Foundation

extension ParseClient{
    
    struct Constants {
        static let AppId = "QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr"
        static let APIKey = "QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY"
        static let APIScheme = "https"
        static let APIHost = "parse.udacity.com"
        static let APIPath = "/parse"
    }
    
    // MARK: Methods
    struct Methods {
        
        // MARK: Account
        static let Account = "/users/{user_id}"
        
        // MARK: Authentication
        static let AuthenticationTokenNew = "/authentication/token/new"
        static let AuthenticationSessionNew = "/session"
        
        // MARK: Get
        static let StudentLocations = "/classes/StudentLocation"
        
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
        static let uniqueKey = "uniqueKey"
        static let firstName = "firstName"
        static let lastName = "lastName"
        static let mapString = "mapString"
        static let mediaURL = "mediaURL"
        static let latitude = "latitude"
        static let longitude = "longitude"
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
        
        // MARK: Student Locations
        static let StudentLocationResults = "results"
        static let FirstName = "firstName"
        static let LastName = "lastName"
        static let Latitude = "latitude"
        static let Longitude = "longitude"
        static let MapString = "mapString"
        static let MediaUrl = "mediaURL"
        static let ObjectID = "objectId"
        static let UniqueKey = "uniqueKey"
    }
}
