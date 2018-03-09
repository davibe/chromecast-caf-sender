//
//  ChromeCastPlayer.swift
//  iOSChromecastSampleApp
//

import Foundation
import CoreMedia
import GoogleCast
import AVFoundation

class ChromeCastPlayer: NSObject {
    
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
    
    let appID = "5A4418C4"
    
    let enableSDKLogging = false
    
    override init()  {
        state = .null
        stateChange = Event()
        currentTime = CMTime.init()
        currentTimeChange = Event()
        curationChange = Event()
        currentBitrateChange = Event()
        
        super.init()
        let criteria = GCKDiscoveryCriteria(applicationID: appID)

        let options = GCKCastOptions(discoveryCriteria: criteria)
        GCKCastContext.setSharedInstanceWith(options)
        GCKCastContext.sharedInstance().useDefaultExpandedMediaControls = true
        GCKCastContext.sharedInstance().sessionManager.add(self)
        
        setupCastLogging()
        
    }
    
    func getCastView( color:UIColor = .black) -> UIView {
        let button = GCKUICastButton.init()
        button.tintColor = color
        return button
    }
    
    func setupCastLogging() {
        let logFilter = GCKLoggerFilter()
        let classesToLog = [
            "GCKDeviceScanner",
            "GCKDeviceProvider",
            "GCKDiscoveryManager",
            "GCKCastChannel",
            "GCKMediaControlChannel",
            "GCKUICastButton",
            "GCKUIMediaController",
            "NSMutableDictionary"
        ]
        logFilter.setLoggingLevel(.verbose, forClasses: classesToLog)
        GCKLogger.sharedInstance().filter = logFilter
        GCKLogger.sharedInstance().delegate = self
    }
    
    func openUrl(
        url: String,
        contentType: String,
        streamType: BasicPlayerStreamType,
        callback:(Bool) -> Void
    ) {
        
        if  let session =  GCKCastContext.sharedInstance().sessionManager.currentCastSession,
            let remoteMediaClient = session.remoteMediaClient {
            
            let metadata = GCKMediaMetadata(metadataType: .generic)
            metadata.setString("Title", forKey: kGCKMetadataKeyTitle)
            metadata.setString("Subtitle", forKey: kGCKMetadataKeySubtitle)
            metadata.addImage(GCKImage(url: URL.init(string: "https://www.rover.com/blog/wp-content/uploads/2017/12/Stocksy_txp9bc11787aNx000_Small_927362-866x540.jpg")! , width: 164, height: 82))
            
            var duration = 60 * 60.0 // 1hr as a start, the player will override it anyway
            if (streamType == .live) { duration = TimeInterval.infinity }
            
            var _streamType: GCKMediaStreamType = .buffered
            if (streamType == .live) { _streamType = .live }
            
            let mediaInfo = GCKMediaInformation(
                contentID: url,
                streamType: _streamType,
                contentType: contentType,
                metadata: metadata,
                streamDuration: duration,
                mediaTracks: nil,
                textTrackStyle: nil,
                customData: nil
            )
            
            let request = remoteMediaClient.loadMedia(mediaInfo)
            
            request.delegate = self
            
            remoteMediaClient.add(self)

            GCKCastContext.sharedInstance().presentDefaultExpandedMediaControls()

            callback(true)
            
        } else {
            callback(false)
        }
    }
    
    func play() {
        if  let session =  GCKCastContext.sharedInstance().sessionManager.currentCastSession,
            let remoteMediaClient = session.remoteMediaClient {
            remoteMediaClient.play()
        }
    }

    func pause() {
        if  let session =  GCKCastContext.sharedInstance().sessionManager.currentCastSession,
            let remoteMediaClient = session.remoteMediaClient {
            remoteMediaClient.pause()
        }
    }

    func seek(to: CMTime, callback: ((Bool) -> Void)?) {
        if  let session =  GCKCastContext.sharedInstance().sessionManager.currentCastSession,
            let remoteMediaClient = session.remoteMediaClient {
            
            let seekOptions = GCKMediaSeekOptions()
            seekOptions.interval = to.seconds
            seekOptions.relative = false
            seekOptions.resumeState = .play
            
            remoteMediaClient.seek(with: seekOptions)
        }
    }


}

extension ChromeCastPlayer: GCKRemoteMediaClientListener {
    func remoteMediaClient(_ client: GCKRemoteMediaClient, didUpdate mediaStatus: GCKMediaStatus?){
        print(mediaStatus)
    }
    
    func remoteMediaClient(_ client: GCKRemoteMediaClient, didStartMediaSessionWithID sessionID: Int){

    }
    
}

extension ChromeCastPlayer: GCKSessionManagerListener {
    func sessionManager(_ sessionManager: GCKSessionManager, didStart session: GCKSession){

    }
    
    func sessionManager(_ sessionManager: GCKSessionManager, didEnd session: GCKSession, withError error: Error?){

    }
    
    func sessionManager(_ sessionManager: GCKSessionManager, didResumeSession session: GCKSession) {

    }
}



// MARK: - GCKRequestDelegate
extension ChromeCastPlayer: GCKRequestDelegate {
    func requestDidComplete(_ request: GCKRequest) {
        print("request \(Int(request.requestID)) completed")
    }
    
    func request(_ request: GCKRequest, didFailWithError error: GCKError) {
        print("request \(Int(request.requestID)) failed with error \(error)")
    }
    
}


// MARK: - GCKLoggerDelegate
extension ChromeCastPlayer: GCKLoggerDelegate {
    func logMessage(_ message: String, fromFunction function: String) {
        if enableSDKLogging {
            // Send SDK's log messages directly to the console.
            print("\(function)  \(message)")
        }
    }
    
}
