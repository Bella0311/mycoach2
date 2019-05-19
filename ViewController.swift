//
//  ViewController.swift
//  DailyMessage
//
//  Created by Isabella Anna Maria Lütken on 19/05/2019.
//  Copyright © 2019 Isabella Anna Maria Lütken. All rights reserved.
//

import UIKit
import FirebaseAuth


class ViewController: UIViewController {
    
    @IBAction func backBtn(_ sender: UIBarButtonItem) {
    }
    @IBOutlet var signInSelector: UISegmentedControl!
    @IBOutlet var emailTxtFiels: UITextField!
    @IBOutlet var passwordTxtFiels: UITextField!
    @IBOutlet var signInBtn: UIButton!
    @IBOutlet var signInLabel: UILabel!
    
    var isSignIn:Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func signInSelectorChanged(_ sender: UISegmentedControl) {
        
        // Flip the boolean
        isSignIn = !isSignIn
        
        //Check the boolean and set the button and labels
        if isSignIn {
            signInLabel.text = "Sign In"
            signInBtn.setTitle("Sign In", for: .normal)
        }
        else {
            signInLabel.text = "Sign Up"
            signInBtn.setTitle("Sign Up", for: .normal)
        }
    }
    
   
    @IBAction func signInBtnTapped(_ sender: UIButton) {
        
        // TODO: Do some form of validation on the email and password
        
        if let email = emailTxtFiels.text, let pass = passwordTxtFiels.text {
        
        // Check if the user pressed sign in or sign up
        if isSignIn{
         // Sign in the user with Firebase
            Auth.auth().signIn(withEmail: email, password: pass,
                               completion: { (user, error) in
                
               //check that user is not nil
                if let u = user {
                    // User is found, go to home screen
                    self.performSegue(withIdentifier: "goToHome", sender: self)
            }
        
            else {
                // Error: check error and show message
            }
                
            })
        }
        else {
            //Register the user with firebase
            Auth.auth().createUser(withEmail: email, password: pass, completion: { (user, error) in
                
                // Check that user is not nil
                if let u = user {
                // User is found, go to home screen
                    self.performSegue(withIdentifier: "goToHome", sender: self)
            }
                else {
                    //Error: check error and show message 
                }
        })
}
}
}
    override func touchesBegan(_ touches: Set<UITouch>, with event:
        UIEvent?) {
        //Dismiss the keyboard when the view is tapped on
        emailTxtFiels.resignFirstResponder()
        passwordTxtFiels.resignFirstResponder()
    }
}
