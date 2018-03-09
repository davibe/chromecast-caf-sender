//
//  MasterViewController.swift
//  iOSChromecastSampleApp
//

import UIKit
import GoogleCast

class MasterViewController: UITableViewController {


    var streams:[Stream] = []

    
    var castPlayer: ChromeCastPlayer?


    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Diva Test iOS"
        self.title = "Diva Test iOS"
        
        castPlayer = ChromeCastPlayer.init()
        if let castButton = castPlayer?.getCastView(color: .blue) {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: castButton)

            self.view.addSubview(castButton)
        }
        
        //HLS STREAMS
        streams.append(Stream(
            name: "Live HLS V3" ,
            url: "https://vod-ffwddevamsmediaservice.streaming.mediaservices.windows.net/68479835-aa9b-4a32-a160-a96ddd8e6507/a3119dfd-7200-4544-ae1f-51867bee04ff.ism/manifest(format=m3u8-aapl-v3)",
            contentType: "application/x-mpegurl",
            type: .live
        ))
        streams.append(Stream(
            name:"Live HLS V4" ,
            url:"https://vod-ffwddevamsmediaservice.streaming.mediaservices.windows.net/68479835-aa9b-4a32-a160-a96ddd8e6507/a3119dfd-7200-4544-ae1f-51867bee04ff.ism/manifest(format=m3u8-aapl-v4)",
            contentType: "application/x-mpegurl",
            type: .live
        ))
        streams.append(Stream(
            name:"Live DASH" ,
            url:"https://vod-ffwddevamsmediaservice.streaming.mediaservices.windows.net/68479835-aa9b-4a32-a160-a96ddd8e6507/a3119dfd-7200-4544-ae1f-51867bee04ff.ism/manifest(format=mpd-time-csf)",
            contentType: "application/dash+xml",
            type: .live
        ))
        streams.append(Stream(
            name:"VOD HLS V3" ,
            url:"https://vod-ffwddevamsmediaservice.streaming.mediaservices.windows.net/4c90b69d-aaeb-4d83-927c-124ffe9ba449/9f156ca8-b15c-4e04-899b-9ca64e156ba9.ism/manifest(format=m3u8-aapl-v3)",
            contentType: "application/x-mpegurl",
            type: .vod
        ))
        streams.append(Stream(
            name:"VOD HLS v4" ,
            url:"https://vod-ffwddevamsmediaservice.streaming.mediaservices.windows.net/4c90b69d-aaeb-4d83-927c-124ffe9ba449/9f156ca8-b15c-4e04-899b-9ca64e156ba9.ism/manifest(format=m3u8-aapl-v4)",
            contentType: "application/x-mpegurl",
            type: .vod
        ))
        streams.append(Stream(
            name:"VOD DASH v4" ,
            url:"https://vod-ffwddevamsmediaservice.streaming.mediaservices.windows.net/4c90b69d-aaeb-4d83-927c-124ffe9ba449/9f156ca8-b15c-4e04-899b-9ca64e156ba9.ism/manifest(format=mpd-time-csf)",
            contentType: "application/dash+xml",
            type: .vod
        ))
        
        
        streams.append(Stream(
            name: "Live HLS V3 BT" ,
            url: "https://t1-btsport-live-hls-test-cluster-c.akamaized.net/out/u/diva_bts2/AUTODIVABTS2D180307S0900E1259.m3u8?hdnea=st=1520389813~exp=1520431170~acl=%2Fout%2Fu%2Fdiva_bts2%2F%2A~hmac=49d50d9bed4f5d6c0731ea0c907975618faea43f74a2bb62b8aa4c2adc4443fe",
            contentType: "application/x-mpegurl",
            type: .live
        ))
        
        streams.append(Stream(
            name: "Live HLS V3 NFL (limited DVR)" ,
            url: "https://livebackup-i-video-nfl.akamaized.net/ch22/85dbfca9-39eb-4ad7-bc13-8fd1c4754943/2f079e82-e722-4472-8b51-e9a1670906c5.ism/manifest(format=m3u8-aapl-v3,filter=connecttv)?hdnea=st=1520418875~exp=1523418875~acl=/*~hmac=a446d4d02129305ba14ab1e0408aa9216b28877cc28277fb9cfde07af28fe7ec&hdcore=2.11.3",
            contentType: "application/x-mpegurl",
            type: .live
        ))
        
        
        // OTHER SAMPLE STREAMS
        
        streams.append(Stream(
            name: "Apple HLS Sample",
            url: "https://devstreaming-cdn.apple.com/videos/streaming/examples/img_bipbop_adv_example_ts/master.m3u8",
            contentType: "application/x-mpegurl",
            type: .vod
        ))
        
        // AKAMAI HLS STREAMS
        // http://players.akamai.com/hls/
        streams.append(Stream(
            name: "AKAMAI HLS Live",
            url: "https://msl4ltctechprvw-i.akamaihd.net/hls/live/263196/ltc-tp-out/master.m3u8",
            contentType: "application/x-mpegurl",
            type: .live
        ))
        streams.append(Stream(
            name: "AKAMAI HLS VOD Big Buck Bunny",
            url: "http://multiplatform-f.akamaihd.net/i/multi/will/bunny/big_buck_bunny_,640x360_400,640x360_700,640x360_1000,950x540_1500,.f4v.csmil/master.m3u8",
            contentType: "application/x-mpegurl",
            type: .vod
        ))
        streams.append(Stream(
            name: "AKAMAI HLS VOD Sintel",
            url: "http://multiplatform-f.akamaihd.net/i/multi/april11/sintel/sintel-hd_,512x288_450_b,640x360_700_b,768x432_1000_b,1024x576_1400_m,.mp4.csmil/master.m3u8",
            contentType: "application/x-mpegurl",
            type: .vod
        ))
        
        
        // AKAMAI DASH STREAMS
        // http://players.akamai.com/dash/
        streams.append(Stream(
            name: "Dash stream",
            url: "https://dash.edgesuite.net/akamai/bbb_30fps/bbb_30fps.mpd",
            contentType: "application/dash+xml",
            type: .vod
        ))

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return streams.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let object = streams[indexPath.row] 
        cell.textLabel!.text = object.name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let stream = streams[indexPath.row]
        var type: BasicPlayerStreamType = .vod
        if (stream.type == .live) { type = .live }

        if GCKCastContext.sharedInstance().castState == .connected {
            
            castPlayer?.openUrl(url: stream.url, contentType: stream.contentType, streamType: type, callback: { (success) in
                print(success)
            })
            
        } else {
            let player = Player.init(vc: self)

            player.openUrl(url: stream.url, contentType: stream.contentType, streamType: type) { (success) in
                print(success)
            }
        }
        
    }

}




