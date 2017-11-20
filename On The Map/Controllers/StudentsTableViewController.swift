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
    var studentLocations: [ParseStudentLocation]!
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        studentLocations = appDelegate.studentLocations
        self.tableView.reloadData()
    }
}

// MARK: - Table view data source
extension StudentsTableViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let studentLocation = studentLocations[indexPath.row]
        if let mediaUrl = studentLocation.mediaURL{
            UIApplication.shared.open(URL(string: mediaUrl)!, options: [:], completionHandler: nil)
        }
    }
}

extension StudentsTableViewController: UITableViewDataSource{
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studentLocations.count
    }

     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StudentCell")!
        let studentLocation = studentLocations[indexPath.row]
        
        cell.textLabel?.text = StringFormat.formatNameText(firstName: studentLocation.firstName, lastName: studentLocation.lastName)
        
        if let mediaURL = studentLocation.mediaURL{
            cell.detailTextLabel?.text = mediaURL
        }else{
            cell.detailTextLabel?.text = "[No Media URL]"
        }
        
        return cell
    }
}
