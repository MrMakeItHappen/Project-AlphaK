//
//  StreamingVideoController.swift
//  Project-Kwicky
//
//  Created by Stanley Miller on 3/30/23.
//

import Foundation
import UIKit
import AVFoundation

final class StreamingVideoController: UIViewController {
    
    var loginController: LoginController?
    var streamUrl: String?
    var playerLayer: AVPlayerLayer?
    var player: AVPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
    }
    
    //MARK: - Class Configuration
    private func configure() {
        self.view.backgroundColor = .black
        
        if self.streamUrl != nil {
            guard let streamUrl = self.streamUrl else { return }
            self.initializeVideoPlayerWithVideo(for: streamUrl)
            print("IF URL IS LIVE AND BROADCASTING, STREAM WILL SHOW...")
            
        } else {
            self.dismiss(animated: true) {
                print("Stream URL is invalid")
            }
        }
    }
    
    //MARK: - Video Stream Player
    private func initializeVideoPlayerWithVideo(for url: String) {
        
        if self.player == nil {
            if let videoURL = URL(string: url) {
                self.player = AVPlayer(url: videoURL)
                self.player?.volume = 0.0
                self.player?.playImmediately(atRate: 1.0)
                
                self.playerLayer = AVPlayerLayer(player: self.player)
                self.playerLayer?.frame = view.bounds
                self.playerLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
                self.playerLayer?.zPosition = 50
                
                self.view.layer.addSublayer(self.playerLayer!)
                self.player?.play()
            }
        }
    }
}

//MARK: - HOPIN STREAM URL
//func HopinStreamUrl(uuidGrab: String, event_id: String, bearerToken: String, completion: @escaping (_ isComplete: Bool, _ streamUrl: String?) -> ()) {
//
//    guard let url = URL(string: "https://staging.hopin.to/api/v2/events/\(event_id)/stage/\(uuidGrab)/status") else { return }
//
//    let session = URLSession.shared
//    var request = URLRequest(url: url)
//
//    request.setValue("Bearer \(bearerToken)", forHTTPHeaderField: "Authorization")
//    session.dataTask(with: request) { (data, response, error) in
//
//        guard let data = data else { return }
//
//        do {
//
//            if let streamUrl = try JSON(data: data)["broadcasts"][0]["stream_url"].string {
//                completion(true, streamUrl)
//            }
//
//        } catch {
//            completion(false, nil)
//        }
//
//    }.resume()
//}
