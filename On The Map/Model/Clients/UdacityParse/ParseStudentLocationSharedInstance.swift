//
//  ParseStudentLocationSharedInstance.swift
//  On The Map
//
//  Created by Octavius Delfyette on 11/26/17.
//  Copyright © 2017 Delfyette Designs. All rights reserved.
//

import Foundation

final class ParseStudentLocationSharedInstance{
    static let sharedInstance = ParseStudentLocationSharedInstance()
    var studentLocations:[ParseStudentLocation]!
    private init() {}
}
