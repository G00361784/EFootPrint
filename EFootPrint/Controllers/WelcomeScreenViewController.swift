//
//  WelcomeScreenViewController.swift
//  EFootPrint
//
//  Created by Joseph Mccole on 04/12/2024.
//

import UIKit
import AVKit

class WelcomeScreenViewController: UIViewController {

    @IBOutlet weak var homeVideoOutlet: UIView!
    private var player: AVPlayer!
        private var playerLayer: AVPlayerLayer!

        override func viewDidLoad() {
            super.viewDidLoad()
            playVideo()
            setupNavigationBar()
        }

        func playVideo() {
            guard let videoPath = Bundle.main.path(forResource: "backgroundvideo", ofType: "mp4") else {
                print("Video not found.")
                return
            }

            let videoURL = URL(fileURLWithPath: videoPath)
            player = AVPlayer(url: videoURL)
            playerLayer = AVPlayerLayer(player: player)

            playerLayer.frame = homeVideoOutlet.bounds
            playerLayer.videoGravity = .resizeAspectFill
            homeVideoOutlet.layer.addSublayer(playerLayer)

            player.play()

            // Loop video
            NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: player.currentItem, queue: .main) { [weak self] _ in
                self?.player.seek(to: CMTime.zero)
                self?.player.play()
            }
        }

        func setupNavigationBar() {
            let navBar = UIView()
            navBar.backgroundColor = .systemBlue
            view.addSubview(navBar)

            // Set constraints for navBar
            navBar.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                navBar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
                navBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                navBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                navBar.heightAnchor.constraint(equalToConstant: 60)
            ])

            // Create and configure buttons
            let homeButton = UIButton(type: .system)
            homeButton.setTitle("Home", for: .normal)
            homeButton.setTitleColor(.label, for: .normal) // Set text color
            homeButton.addTarget(self, action: #selector(homeButtonTapped), for: .touchUpInside) // Add target action

            let mapButton = UIButton(type: .system)
            mapButton.setTitle("Map", for: .normal)
            mapButton.setTitleColor(.label, for: .normal) // Set text color
            mapButton.addTarget(self, action: #selector(mapButtonTapped), for: .touchUpInside) // Add target action


            // Add buttons to navBar
            navBar.addSubview(homeButton)
            navBar.addSubview(mapButton)


            // Set constraints for buttons (example - adjust as needed)
            homeButton.translatesAutoresizingMaskIntoConstraints = false
            mapButton.translatesAutoresizingMaskIntoConstraints = false

            NSLayoutConstraint.activate([
                homeButton.leadingAnchor.constraint(equalTo: navBar.leadingAnchor, constant: 20), // Adjust spacing
                homeButton.centerYAnchor.constraint(equalTo: navBar.centerYAnchor),

                mapButton.trailingAnchor.constraint(equalTo: navBar.trailingAnchor, constant: -20), // Adjust spacing
                mapButton.centerYAnchor.constraint(equalTo: navBar.centerYAnchor),
            ])
        }

        @objc func homeButtonTapped() {
            print("Home button tapped")
            // Handle home button action (e.g., navigate to home screen)
        }

        @objc func mapButtonTapped() {
            print("Map button tapped")
            // Handle map button action (e.g., navigate to map screen)
        }
    }
