//
//  Player.swift
//  iOSChromecastSampleApp
//

import Foundation
import CoreMedia
import AVFoundation
import AVKit

class Player: NSObject {
    
    var controller:UIViewController?
    
    
    var state: BasicPlayerState
    var stateChange: Event<(old: BasicPlayerState, new: BasicPlayerState)>
    var currentTime: CMTime
    var currentTimeChange: Event<CMTime>
    var duration: CMTime?
    var curationChange: Event<CMTime?>
    var currentBitrate: Double?
    var currentBitrateChange: Event<Double?>
    var maxBitrate: Double?
    var maxResolution: CGSize?
    var player:AVPlayer?
    

    init(vc:UIViewController)  {
        state = .null
        stateChange = Event()
        currentTime = CMTime.init()
        currentTimeChange = Event()
        curationChange = Event()
        currentBitrateChange = Event()
        controller = vc
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func openUrl(url: String, contentType: String, streamType: BasicPlayerStreamType, callback: (Bool) -> Void) {
    
        guard let _ = self.controller, let playerURL = URL.init(string: url) else {
            callback(false)
            return
        }
        // Create an AVPlayer, passing it the HTTP Live Streaming URL.
        player = AVPlayer(url: playerURL)
        
        // Create a new AVPlayerViewController and pass it a reference to the player.
        let avController = AVPlayerViewController()
        avController.player = player
        
        // Modally present the player and call the player's play() method when complete.
        controller?.present(avController, animated: true) {
            self.player?.play()
        }
        
        callback(true)
    }
    
    //TODO:
    func play() {
        player?.play()
        
    }
    //TODO:
    func pause() {
        player?.pause()
    }
    //TODO:
    func seek(to: CMTime, callback: ((Bool) -> Void)?) {
        player?.pause()
    }

}
