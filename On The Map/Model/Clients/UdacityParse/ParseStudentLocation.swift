//
//  ParseStudentLocation.swift
//  On The Map
//
//  Created by Octavius on 11/6/17.
//  Copyright © 2017 Delfyette Designs. All rights reserved.
//

import Foundation

struct ParseStudentLocation{
    
    //MARK: Variables
    
    let objectId: String?
    let uniqueKey: String?
    let firstName: String?
    let lastName: String?
    let mapString: String?
    let mediaURL: String?
    let latitude: Double?
    let longitude: Double?
    
    //MARK: Init
    
    init?(dictionary: [String:AnyObject]) {
        objectId = dictionary[ParseClient.JSONResponseKeys.ObjectID] as? String
        uniqueKey = dictionary[ParseClient.JSONResponseKeys.UniqueKey] as? String
        firstName = dictionary[ParseClient.JSONResponseKeys.FirstName] as? String
        lastName = dictionary[ParseClient.JSONResponseKeys.LastName] as? String
        mapString = dictionary[ParseClient.JSONResponseKeys.MapString] as? String
        mediaURL = dictionary[ParseClient.JSONResponseKeys.MediaUrl] as? String
        latitude = dictionary[ParseClient.JSONResponseKeys.Latitude] as? Double
        longitude = dictionary[ParseClient.JSONResponseKeys.Longitude] as? Double
    }
    
    //MARK: Helpers
    
    static func studentLocationFromResults(_ results: [[String:AnyObject]]) -> [ParseStudentLocation] {
        
        var studentLocation = [ParseStudentLocation]()
        
        for result in results {
            studentLocation.append(ParseStudentLocation(dictionary: result)!)
        }
        
        return studentLocation
    }
    
}
