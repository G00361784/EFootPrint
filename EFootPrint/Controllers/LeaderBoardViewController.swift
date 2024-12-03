//
//  LeaderBoardViewController.swift
//  EFootPrint
//
//  Created by Joseph Mccole on 03/12/2024.
//

import UIKit
import FirebaseDatabase

class LeaderBoardViewController: UIViewController {

    @IBOutlet weak var leaderBoardLabel: UILabel!
    var ref: DatabaseReference!

    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()

        ref.child("playerinfo").child("player1").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get player data
            let value = snapshot.value as? [String: Any]
            let name = value?["name"] as? String ?? ""
            let age = value?["age"] as? Int ?? 0
            let score = value?["score"] as? Int ?? 0

            // Now you have the player's name, age, and score
            print("Name: \(name), Age: \(age), Score: \(score)")
            self.leaderBoardLabel.text = "\(name) \(age) \(score)"
            // ... (update UI elements with the retrieved data) ...

        }) { (error) in
            print(error.localizedDescription)
        }
    }
}
