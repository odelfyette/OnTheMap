//
//  SetLocationViewController.swift
//  On The Map
//
//  Created by Octavius on 11/10/17.
//  Copyright © 2017 Delfyette Designs. All rights reserved.
//

import UIKit

class SetLocationViewController: UIViewController {

    //MARK: Variables
    
    @IBOutlet weak var studentLocation: UITextField!
    @IBOutlet weak var studentMediaUrl: UITextField!
    
    //MARK LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        studentMediaUrl.delegate = self
        studentLocation.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        subcribeToKeyboardNotificiations()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeToKeyboardNotifications()
    }
    
    //MARK: Action Buttons
    
    @IBAction func cancel(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        let controller = self.storyboard!.instantiateViewController(withIdentifier: "LoadingStudentsViewController") as! LoadingStudentsViewController
        self.present(controller, animated: true, completion: nil)
    }
    
    @IBAction func findLocation(_ sender: Any) {
        if(validateFields()){
            performSegue(withIdentifier: "Share Link", sender: nil)
        }
    }
    
    //MARK: Validations
    
    func validateFields() -> Bool{
        var validFields = true
        var alert:UIAlertController!
        
        if(studentLocation.text!.isEmpty){
            alert = UIAlertController(title: "No location Entered", message: "Please enter a location", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
            validFields = false
        }
        if(studentMediaUrl.text!.isEmpty){
            alert = UIAlertController(title: "No URL Entered", message: "Please enter a URL", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
            validFields = false
        }
        
        if(!validFields){
            self.present(alert, animated: true, completion: nil)
        }
        
        return validFields
    }
    
    //MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Share Link"{
            let shareLocVC = segue.destination as! ShareLocationViewController
            shareLocVC.studentLocation = studentLocation.text
            shareLocVC.studentMediaLink = studentMediaUrl.text
        }
    }
    
    //MARK: Keyboard Actions
    
    @objc func keyboardWillShow(notification: NSNotification){
        self.view.frame.origin.y = 100 - getKeyboardHeight(notification: notification)
    }
    
    @objc func keyboardWillHide(notification: NSNotification){
        self.view.frame.origin.y = 0
    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat{
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
    
    func subcribeToKeyboardNotificiations(){
        NotificationCenter.default.addObserver(self, selector: #selector(SetLocationViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(SetLocationViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func unsubscribeToKeyboardNotifications(){
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }

}

//MARK: Text Field Delegates

extension SetLocationViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
}
