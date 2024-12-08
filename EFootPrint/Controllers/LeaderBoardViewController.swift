//
//  LeaderBoardViewController.swift
//  EFootPrint
//
//  Created by Joseph Mccole on 03/12/2024.
//

import UIKit
import FirebaseDatabase

class LeaderBoardViewController: UIViewController, UITableViewDataSource  {

    @IBOutlet weak var tableView: UITableView!
    
    
    
    
    @IBOutlet weak var leaderBoardLabel: UILabel!
    var ref: DatabaseReference!
        var players: [[String: Any]] = [] // Array to store player data

        override func viewDidLoad() {
            super.viewDidLoad()
            ref = Database.database().reference()
            tableView.dataSource = self

            ref.child("playerinfo").observeSingleEvent(of: .value, with: { (snapshot) in
                guard let value = snapshot.value as? [String: [String: Any]] else { return }

                for playerData in value.values {
                    self.players.append(playerData)
                }

                self.tableView.reloadData() // Refresh the table view

            }) { (error) in
                print(error.localizedDescription)
            }
        }

        // MARK: - UITableViewDataSource

        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return players.count
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "playerCell", for: indexPath) // Make sure you have a cell with this identifier in your storyboard
            let player = players[indexPath.row]

            let name = player["name"] as? String ?? ""
            let age = player["age"] as? Int ?? 0
            let score = player["score"] as? Int ?? 0

            cell.textLabel?.text = "\(name) - Age: \(age) - Score: \(score)"

            return cell
        }
    }
