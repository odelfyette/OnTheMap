//
//  Helper.swift
//  On The Map
//
//  Created by Octavius on 11/14/17.
//  Copyright © 2017 Delfyette Designs. All rights reserved.
//

import Foundation

class StringFormat{
    static func formatNameText(firstName: String?, lastName: String?) -> String{
        var firstNameText:String!
        var lastNameText:String!
        
        if let firstName = firstName{
            firstNameText = firstName
        }else{
            firstNameText = "[No First Name]"
        }
        if let lastName = lastName{
            lastNameText = lastName
        }else{
            lastNameText = "[No Last Name]"
        }
        
        return "\(firstNameText!) \(lastNameText!)"
    }
}
