//
//  BasicPlayerProtocol.swift
//  DivaIOS
//

import Foundation
import AVKit

@objc public enum BasicPlayerState: Int {
    case null = 0
    case paused = 1
    case playing = 2
    case failed = 3
    
    func toString() -> String {
        switch self {
        case .null: return "null" // stopped
        case .paused: return "paused"
        case .playing: return "playing"
        case .failed: return "failed"
        }
    }
}

enum BasicPlayerStreamType {
    case live
    case vod
}

