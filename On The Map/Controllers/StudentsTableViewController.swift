//
//  StudentsTableViewController.swift
//  On The Map
//
//  Created by Octavius on 11/4/17.
//  Copyright © 2017 Delfyette Designs. All rights reserved.
//

import UIKit

class StudentsTableViewController: UIViewController {
    
    //MARK: Variables
    
    let appDelegate = (UIApplication.shared.delegate as! AppDelegate)
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: LifeCycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    
    //MARK: Helpers
}

// MARK: - Table view data source
extension StudentsTableViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let studentLocation = ParseStudentLocationSharedInstance.sharedInstance.studentLocations[indexPath.row]
        
        if(ValidateURL.isValidURL(urlString: studentLocation.mediaURL)){
            UIApplication.shared.open(URL(string: studentLocation.mediaURL!)!, options: [:], completionHandler: nil)
        }else{
            ValidateURL.showInvalidUrlMessage(viewCtrl: self)
        }
    }
}

extension StudentsTableViewController: UITableViewDataSource{
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ParseStudentLocationSharedInstance.sharedInstance.studentLocations.count
    }

     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StudentCell")!
        let studentLocation = ParseStudentLocationSharedInstance.sharedInstance.studentLocations[indexPath.row]
        
        cell.textLabel?.text = StringFormat.formatNameText(firstName: studentLocation.firstName, lastName: studentLocation.lastName)
        
        if let mediaURL = studentLocation.mediaURL{
            cell.detailTextLabel?.text = mediaURL
        }else{
            cell.detailTextLabel?.text = "[No Media URL]"
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
