//
//  SignUpViewController.swift
//  PrenticeBrothers
//
//  Created by Rachel Wilson on 5/30/19.
//  Copyright © 2019 Dylan Anderson. All rights reserved.
//

import UIKit
import CoreGraphics
import FirebaseAuth
import FirebaseDatabase
import CoreData

class SignUpViewController: UIViewController {

    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    //The forgot password outlet is also the continue as guest button
    @IBOutlet weak var forgotPassword: UIButton!
    
    var signUpMode = true
    var needForgotPasswordButton = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 52/255, green: 73/255, blue: 94/255, alpha: 1.0)
        
        logo.layer.cornerRadius = logo.frame.width/3.5
        
    }

    @IBAction func signUpPressed(_ sender: Any) {
        if firstNameTextField.text == "" || lastNameTextField.text == "" || emailTextField.text == "" || passwordTextField.text == "" {
            // Empty text fields
            displayAlert(title: "Missing Information", message: "Please enter the missing information to continue")
        } else {
            #warning("Link the data to Core Data")
            if let email = emailTextField.text {
                if let password = passwordTextField.text {
                    if signUpMode {
                        // Create a user in firebase authorization.
                        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
                            if error != nil {
                                self.displayAlert(title: "Error", message: error!.localizedDescription)
                            } else {
                                self.performSegue(withIdentifier: "goToInitialController", sender: nil)
                            }
                        }
                    } else {
                        // Log user in
                        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
                            if error != nil {
                                self.displayAlert(title: "Error", message: error!.localizedDescription)
                            } else {
                                self.performSegue(withIdentifier: "goToInitialController", sender: nil)
                            }
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func logInPressed(_ sender: Any) {
        if signUpMode {
            // User trying to login in
            signUpButton.setTitle("Login", for: .normal)
            loginButton.setTitle("or Sign Up", for: .normal)
            signUpMode = false
            firstNameTextField.isHidden = true
            lastNameTextField.isHidden = true
            
            needForgotPasswordButton = true
            forgotPassword.setTitle("Forgot password?", for: .normal)
        } else {
            signUpButton.setTitle("Sign Up", for: .normal)
            loginButton.setTitle("or Login", for: .normal)
            signUpMode = true
            firstNameTextField.isHidden = false
            lastNameTextField.isHidden = false
            
            needForgotPasswordButton = false
            forgotPassword.setTitle("Continue as guest", for: .normal)
        }
    }
    @IBAction func guestPressed(_ sender: Any) {
        if needForgotPasswordButton {
            #warning("Link to firebase systems on how to reset password")
            print("Password reset button")
        } else {
            // Continue as guest
            let message = "If you continue as a guest you cannot redeem loyalty points."
            let alertController = UIAlertController(title: "Are you sure?", message: message, preferredStyle: .alert)
            // Create OK button
            let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
                // Code in this block will trigger when OK button tapped.
                self.performSegue(withIdentifier: "goToInitialController", sender: nil)
                #warning("Add the core data first name to be an empty string")
                #warning("Track analytics how many users are clicking this button")
            }
            alertController.addAction(OKAction)
            // Create Cancel button
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action:UIAlertAction!) in
                
            }
            alertController.addAction(cancelAction)
            // Present Dialog message
            self.present(alertController, animated: true, completion:nil)
        }
    }
    
    func displayAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    
}
