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
        }

        func playVideo() {
            guard let videoPath = Bundle.main.path(forResource: "backgroundvideo", ofType: "mp4") else {
                print("Video not found.")
                return
            }

            let videoURL = URL(fileURLWithPath: videoPath)
            player = AVPlayer(url: videoURL)
            playerLayer = AVPlayerLayer(player: player)

            // Use homeVideoOutlet instead of videoView
            playerLayer.frame = homeVideoOutlet.bounds
            playerLayer.videoGravity = .resizeAspectFill
            homeVideoOutlet.layer.addSublayer(playerLayer)

            player.play()
            
            NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: player.currentItem, queue: .main) { [weak self] _ in
                    self?.player.seek(to: CMTime.zero)
                    self?.player.play()
                }
        }
    }
