//
//  Stream.swift
//  iOSChromecastSampleApp
//

import Foundation

enum StreamType {
    case live
    case vod
}

class Stream: NSObject {
    
    var name: String
    var url: String
    var thumb: String?
    var contentType: String
    var type: StreamType
    
    init(name:String, url: String, thumb: String? = nil, contentType: String, type: StreamType) {
        self.name = name
        self.url = url
        self.thumb = thumb
        self.contentType = contentType
        self.type = type
    }
    
}
