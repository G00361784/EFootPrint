//
//  ViewController.swift
//  EFootPrint
//
//  Created by Joseph Mccole on 13/11/2024.
//

import UIKit
import FirebaseCore
import FirebaseAuth
class ViewController: UIViewController {
   
    
    func showError(_ message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    @IBOutlet weak var LoginOutlet: UITextField!
    
    @IBOutlet weak var passwordOutlet: UITextField!
    

    @IBAction func registerPressed(_ sender: UIButton) {
        if let email = LoginOutlet.text, let password = passwordOutlet.text {
            
            // Ensure email and password are not empty
            if email.isEmpty || password.isEmpty {
                // Display an error message to the user (e.g., using an alert)
                showError("Please enter both email and password.")
                return
            }
            
            if password.count < 6 {
                // Display an error for weak password
                showError("Password must be at least 6 characters long.")
                return
            }
            
            // Create user with Firebase Auth
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    // Display error to the user
                    self.showError(e.localizedDescription)
                } else {
                    // Success! Perform the segue
                   self.performSegue(withIdentifier: "toHomeScreen", sender: self)
                }
            }
        } else {
            // Handle the case where email or password are nil (shouldn't happen)
            showError("Email or password cannot be nil.")
        }
    }
    }
