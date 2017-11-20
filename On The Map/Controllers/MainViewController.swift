//
//  MainViewController.swift
//  On The Map
//
//  Created by Octavius on 11/13/17.
//  Copyright © 2017 Delfyette Designs. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    //MARK: Action Buttons
    
    @IBAction func refresh(_ sender: Any) {
        let controller = self.storyboard!.instantiateViewController(withIdentifier: "LoadingStudentsViewController") as! LoadingStudentsViewController
        self.present(controller, animated: true, completion: nil)
    }
    
    @IBAction func logout(_ sender: Any) {
        UdacityClient.sharedInstance().logout { (success, errorString) in
            if success {
                self.goToSignOn()
            } else {
                self.displayError()
            }
        }
    }
    
    //MARK: Helpers
    
    func goToSignOn(){
        performUIUpdatesOnMain {
            self.navigationController?.dismiss(animated: true, completion: nil)
        }
    }
    
    func displayError(){
        performUIUpdatesOnMain {
            let alert = UIAlertController(title: "Error", message: "There was an error logging out", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}
