//
//  UdacityAuthFlow.swift
//  On The Map
//
//  Created by Octavius on 10/27/17.
//  Copyright © 2017 Delfyette Designs. All rights reserved.
//

import Foundation
import UIKit

extension UdacityClient{
 
    //MARK: Authenication
    
    func authenticate(loginParameters: [String: AnyObject], completionHandlerForAuth: @escaping (_ success: Bool, _ errorString: String?) -> Void) {
        
        self.getSessionID(loginParameters: loginParameters) { (success, sessionID, errorString) in
            
            if success {
                
                self.sessionID = sessionID
                
                self.getUser() { (success, userID, errorString) in

                    if success {

                        if let userID = userID {
                            self.userID = userID
                        }
                    }

                    completionHandlerForAuth(success, errorString)
                }
            } else {
                completionHandlerForAuth(success, errorString)
            }
        }
    }
    
    //MARK: Logout
    
    func logout(_ completionHandlerForLogOut: @escaping (_ success: Bool, _ errorString: String?) -> Void){
        let method = Methods.AuthenticationSessionNew
        
        let _ = taskForDELETEMethod(method, parameters: [:]){ (results, error) in
            if let error = error {
                print(error)
                completionHandlerForLogOut(false, "Login Failed LogOut.")
            } else {
                completionHandlerForLogOut(true, nil)
            }
        }
    }
    
    //MARK: GET
    
    private func getUser(_ completionHandlerForUserID: @escaping (_ success: Bool, _ userID: Int?, _ errorString: String?) -> Void) {
        
        let parameters = [ParameterKeys.UserID: self.userID]
        var mutableMethod : String = Methods.Account
        mutableMethod = substituteKeyInMethod(mutableMethod, key: URLKeys.UserID, value: String(self.userID!))!
        
        let _ = taskForGETMethod(mutableMethod, parameters: parameters as [String:AnyObject]) { (results, error) in
            
            if let error = error {
                print(error)
                completionHandlerForUserID(false, nil, "Login Failed (User ID).")
            } else {
                if let user = results?[JSONResponseKeys.User] as? [String: AnyObject]{
                    if let lastName = user[JSONResponseKeys.LastName] as? String{
                       self.lastName = lastName
                    }
                    
                    if let firstName = user[JSONResponseKeys.FirstName] as? String{
                        self.firstName = firstName
                    }
                }
                
                completionHandlerForUserID(true, self.userID, nil)
            }
        }
    }
    
    private func getSessionID(loginParameters: [String: AnyObject], completionHandlerForSession: @escaping (_ success: Bool, _ sessionID: String?, _ errorString: String?) -> Void) {

        let jsonBody = "{\"udacity\": {\"\(ParameterKeys.Username)\": \"\(String(describing: loginParameters["username"]!))\", \"\(ParameterKeys.Password)\": \"\(String(describing: loginParameters["password"]!))\"}}"
        
        let _ = taskForPOSTMethod(Methods.AuthenticationSessionNew, parameters: loginParameters, jsonBody: jsonBody) { (results, error) in
            
            if let error = error {
                print(error)
                completionHandlerForSession(false, nil, "Login Failed (Session ID).")
            } else {
                if let session = results?[JSONResponseKeys.Session] as? [String : AnyObject] {
                    if let sessionID = session[JSONResponseKeys.SessionID] as? String {
                        self.setUserID(results: results)
                        completionHandlerForSession(true, sessionID, nil)
                    }
                } else {
                    print("Could not find \(JSONResponseKeys.SessionID) in \(results!)")
                    completionHandlerForSession(false, nil, "Login Failed (Session ID).")
                }
            }
        }
    }
    
    //MARK: Helpers
    
    private func setUserID(results: AnyObject?){
        if let account = results?[JSONResponseKeys.UserAccount] as? [String : AnyObject] {
            if let userID = account[JSONResponseKeys.UserID] as? String {
                self.userID = Int(userID)
            }
        }
    }
}
