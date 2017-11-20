//
//  AppDelegate.swift
//  On The Map
//
//  Created by Octavius Delfyette on 10/21/17.
//  Copyright © 2017 Delfyette Designs. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var studentLocations = [ParseStudentLocation]()
    var sharedSession = URLSession.shared
    var requestToken: String? = nil
    var sessionID: String? = nil
    var userID: Int? = nil

}
