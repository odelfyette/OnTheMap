//
//  ValidateURL.swift
//  On The Map
//
//  Created by Octavius Delfyette on 11/24/17.
//  Copyright © 2017 Delfyette Designs. All rights reserved.
//

import Foundation
import UIKit

class ValidateURL{
    static func isValidURL(urlString: String?) -> Bool{
        
        if let _ = urlString{
            let mediaURL = URL(string: urlString!)
            
            if let mediaURL = mediaURL{
                if(UIApplication.shared.canOpenURL(mediaURL)){
                    return true
                }else{
                    return false
                }
            }else{
                return false
            }
        }else{
            return false
        }
    }
    
    static func showInvalidUrlMessage(viewCtrl: UIViewController){
        let alert = UIAlertController(title: "Invalid URL", message: "The URL for this student is invalid", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
        viewCtrl.present(alert, animated: true, completion: nil)
    }
}
