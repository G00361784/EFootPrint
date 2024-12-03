//
//  LeaderBoardViewController.swift
//  EFootPrint
//
//  Created by Joseph Mccole on 03/12/2024.
//

import UIKit
import FirebaseDatabase
class LeaderBoardViewController: UIViewController {

    
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()  // Do any additional setup after loading the view.
    }
    
    
    
   
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
