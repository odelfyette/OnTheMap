//
//  LoadingStudentsViewController.swift
//  On The Map
//
//  Created by Octavius on 11/16/17.
//  Copyright © 2017 Delfyette Designs. All rights reserved.
//

import UIKit

class LoadingStudentsViewController: UIViewController {

    //MARK: Helpers
    
    let appDelegate = (UIApplication.shared.delegate as! AppDelegate)
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    //MARK: LifeCycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getStudentLocations()
    }
    
    //MARK: GET
    
    func getStudentLocations(){
        activityIndicator.alpha = 1
        activityIndicator.startAnimating()
        
        ParseClient.sharedInstance().getStudentLocations{(studentLocations, error) in
            if let studentLocations = studentLocations{
                self.appDelegate.studentLocations = studentLocations
            }else{
                print(error ?? "no student locations retrieved")
            }
            performUIUpdatesOnMain {
                self.activityIndicator.stopAnimating()
                self.activityIndicator.alpha = 0
                self.dismiss(animated: true, completion: nil)
                let studentMap = self.storyboard?.instantiateViewController(withIdentifier: "StudentMap") as! StudentMapViewController
                print(studentMap)
            }
        }
    }

}
