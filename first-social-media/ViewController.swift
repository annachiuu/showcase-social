//
//  ViewController.swift
//  first-social-media
//
//  Created by anna :)  on 8/9/16.
//  Copyright © 2016 Anna Chiu. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit
import Firebase
import FirebaseAuth

class ViewController: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if NSUserDefaults.standardUserDefaults().valueForKey(UID_KEY) != nil { //if already logged in, show the next view controller
            self.performSegueWithIdentifier(SEGUE_LOGGED_IN, sender: nil)
        } else {
            print("Not logged In" )
        }
    }
    
    @IBAction func fbBtnPressed(sender: UIButton!) {
        let facebookLogin = FBSDKLoginManager()
        
        facebookLogin.logInWithReadPermissions(["email"], fromViewController: self, handler: {(facebookResult: FBSDKLoginManagerLoginResult!, facebookError: NSError!) in
            if facebookError != nil  {
                print("Facebook login failed. Error \(facebookError)")
            } else {
                let accessToken = FIRFacebookAuthProvider.credentialWithAccessToken(FBSDKAccessToken.currentAccessToken().tokenString);
                let printableAccessToken: String = FBSDKAccessToken.currentAccessToken().tokenString
                
                print("Sucessfully logged in with facebook. \(printableAccessToken)")
                
                
                FIRAuth.auth()?.signInWithCredential(accessToken, completion: { (authData: FIRUser?, error: NSError?) in
                    
                    if error != nil {
                        print("login failed. \(error)")
                    } else {
                        print("Logged In! \(accessToken)")
                        
                        
                        let user = ["provider": accessToken.provider, "blah" : "test"]
                        
                        DataService.ds.createFirebaseUser(authData!.uid, user: user)
                        
                        NSUserDefaults.standardUserDefaults().setValue(authData?.uid, forKey: UID_KEY)
                        self.performSegueWithIdentifier(SEGUE_LOGGED_IN, sender: nil)
                    }
                })
            }
        })
        
    }
    
    
    @IBAction func attemptLogin(sender: UIButton!) {
        
        if let email = emailField.text where email != "", let pwd = passwordField.text where pwd != "" {
            FIRAuth.auth()?.createUserWithEmail(emailField.text!, password: passwordField.text!, completion: { (user: FIRUser?, SignupError: NSError?) in
                
                if SignupError != nil {
                    print("ACCOUNT HAS BEEN FOUND \(SignupError)")
                    self.login()
                } else {
                    print("USER CREATED \(user)")
                    self.login()
                }
                
            })
        } else {
            showErrorAlert("Email and Password Required", msg: "Please check if you entered an email and password")
        }
        
        
    }
    
    func login() {
        
        FIRAuth.auth()?.signInWithEmail(emailField.text!, password: passwordField.text!, completion: { (authData: FIRUser?, LoginError: NSError?) in
            
            if LoginError != nil {
                
                if self.passwordField.text?.characters.count < 6 {
                    self.showErrorAlert("Re-enter Password", msg: "Password must be at least 6 characters")
                } else {
                
                print("INCORRECT EMAIL OR PASSWORD \(LoginError)")
                self.showErrorAlert("Incorrect Password ", msg: "Please check if you have entered the correct password")
                }
                
            } else {
                print("LOGGED IN \(authData)")
                
                let user: [String: String] = ["provider": "email", "blah2": "test2"]
                DataService.ds.createFirebaseUser(authData!.uid, user: user)
                
                NSUserDefaults.standardUserDefaults().setValue(authData?.uid, forKey: UID_KEY)
                self.performSegueWithIdentifier(SEGUE_LOGGED_IN, sender: nil)
            }
        })
        
    }
    
    func showErrorAlert(title: String, msg: String) {
        
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .Alert)
        let action = UIAlertAction(title: "Ok", style: .Default, handler: nil)
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
    }
    
    
    
}













