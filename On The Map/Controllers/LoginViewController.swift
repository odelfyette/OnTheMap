//
//  LoginViewController.swift
//  On The Map
//
//  Created by Octavius Delfyette on 10/21/17.
//  Copyright © 2017 Delfyette Designs. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    //MARK: Properties
    var appDelegate: AppDelegate!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var debugTextLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var createAccountButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    //MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.debugTextLabel.text = ""
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        emailTextField.delegate = self
        passwordTextField.delegate = self
        setUIEnabled(enabled: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        subcribeToKeyboardNotificiations()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeToKeyboardNotifications()
    }
    
    //MARK: Login
    
    @IBAction func attemptLogin(_ sender: Any) {
        if emailTextField.text!.isEmpty || passwordTextField.text!.isEmpty {
            debugTextLabel.text = "Username or Password Empty."
        } else {
            setUIEnabled(enabled: false)
            
            let methodParameters = [
                UdacityClient.ParameterKeys.Username: emailTextField.text,
                UdacityClient.ParameterKeys.Password: passwordTextField.text
            ]
            
            UdacityClient.sharedInstance().authenticate(loginParameters: methodParameters as [String : AnyObject]) { (success, errorString) in
                    performUIUpdatesOnMain {
                        if success {
                            self.completeLogin()
                        } else {
                            self.displayError(errorString)
                        }
                        self.setUIEnabled(enabled: true)
                    }
            }
        }
    }
    
    
    @IBAction func createAccount(_ sender: Any) {
        let signUpLink = "https://www.udacity.com/account/auth#!/signup"
        UIApplication.shared.open(URL(string: signUpLink)!, options: [:], completionHandler: nil)
    }
    
    private func completeLogin() {
        performUIUpdatesOnMain {
            self.debugTextLabel.text = ""
            self.emailTextField.text = ""
            self.passwordTextField.text = ""
            self.setUIEnabled(enabled: true)
            let controller = self.storyboard!.instantiateViewController(withIdentifier: "ManagerNavigationController") as! UINavigationController
            self.present(controller, animated: true, completion: nil)
        }
    }
    
    //MARK: Keyboard Actions
    
    @objc func keyboardWillShow(notification: NSNotification){
        if passwordTextField.isFirstResponder{
            self.view.frame.origin.y = 150 - getKeyboardHeight(notification: notification)
        }
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
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func unsubscribeToKeyboardNotifications(){
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
}

// MARK: - LoginViewController (Configure UI)

private extension LoginViewController {
    
    private func setUIEnabled(enabled: Bool){
        loginButton.isEnabled = enabled
        createAccountButton.isEnabled = enabled
        
        if enabled{
            loginButton.alpha = 1.0
            activityIndicator.stopAnimating()
            activityIndicator.alpha = 0
        }else{
            loginButton.alpha = 0.5
            activityIndicator.startAnimating()
            activityIndicator.alpha = 1
        }
    }
    
    func displayError(_ errorString: String?) {
        if let errorString = errorString {
            debugTextLabel.text = errorString
        }
    }
}

extension LoginViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        return true
    }
}

