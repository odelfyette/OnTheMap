//
//  ParseStudentCalls.swift
//  On The Map
//
//  Created by Octavius on 11/6/17.
//  Copyright © 2017 Delfyette Designs. All rights reserved.
//

import Foundation

extension ParseClient{
    
    //MARK: GET
    
    func getStudentLocations(_ completionHandlerForStudLoc: @escaping (_ result: [ParseStudentLocation]?, _ error: NSError?) -> Void) {
        
        let parameters:[String : AnyObject] = [
            ParameterKeys.Limit: Constants.Limit,
            ParameterKeys.Order: Constants.Order as AnyObject
        ]
        
        let method : String = Methods.StudentLocations
        
        let _ = taskForGETMethod(method, parameters: parameters as [String : AnyObject] ) { (results, error) in
            
            if let error = error {
                print(error)
                completionHandlerForStudLoc(nil, NSError(domain: "getStudentLocations recieving results", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not get results from getStudentLocations"]))
            } else {
                if let results = results?[JSONResponseKeys.StudentLocationResults] as? [[String:AnyObject]] {
                    
                    let studentLocations = ParseStudentLocation.studentLocationFromResults(results)
                    completionHandlerForStudLoc(studentLocations, nil)
                } else {
                    completionHandlerForStudLoc(nil, NSError(domain: "getStudentLocations parsing", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not parse getStudentLocations"]))
                }
            }
        }
    }
    
    //MARK: POST
    
    func postNewStudent(_ completionHandlerForAddStud: @escaping (_ result: Bool, _ error: NSError?) -> Void) {
        
        let parameters = [String:AnyObject]()
        
        let jsonBody = "{\"\(ParameterKeys.uniqueKey)\":\"\(String(describing: UdacityClient.sharedInstance().userID!))\",\"\(ParameterKeys.firstName)\": \"\(String(describing: UdacityClient.sharedInstance().firstName!))\",\"\(ParameterKeys.lastName)\":\"\(String(describing: UdacityClient.sharedInstance().lastName!))\",\"\(ParameterKeys.mapString)\":\"\(String(describing: mapString!))\",\"\(ParameterKeys.mediaURL)\":\"\(String(mediaUrl))\",\"\(ParameterKeys.latitude)\":\(latitude!),\"\(ParameterKeys.longitude)\":\(longitude!)}"

        
        let _ = taskForPOSTMethod(Methods.StudentLocations, parameters: parameters, jsonBody: jsonBody) { (results, error) in
            
            if let error = error {
                print(error)
                completionHandlerForAddStud(false, error)
            } else {
               completionHandlerForAddStud(true, nil)
            }
        }
    }
}
