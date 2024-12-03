//
//  LoginViewController.swift
//  EFootPrint
//
//  Created by Joseph Mccole on 26/11/2024.
//

import UIKit
import FirebaseCore
import FirebaseAuth
class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
    
    @IBAction func LoginPressed(_ sender: UIButton) {
        if let email = LoginEmail.text, let password = LoginPassword.text {
            
            
            Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
                guard let strongSelf = self else { return }
                if let e = error{
                    print(e.localizedDescription)
                }else{
                    self?.performSegue(withIdentifier: "toHomeScreenFromL", sender: self)
                }
            }
            
        }
    }
    
    @IBOutlet weak var LoginPassword: UITextField!
    @IBOutlet weak var LoginEmail: UITextField!
}
