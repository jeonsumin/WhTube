//
//  ContentDetailViewController.swift
//  WhTube
//
//  Created by Terry on 2020/12/02.
//

import UIKit
import YoutubePlayer_in_WKWebView
import MapKit

class ContentDetailViewController: UIViewController {

    @IBOutlet weak var playerView: WKYTPlayerView!
    @IBOutlet weak var map: MKMapView!
    
    let playerVersion = ["playsinline":1]
 
    var videoId = ""
    var contentBy : contents!
    //MARK: - LifeCycel
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.prefersLargeTitles = false
        playerView.load(withVideoId: contentBy.videoLinkId, playerVars :playerVersion)
        playerView.delegate = self
        navigationController?.navigationBar.barStyle = .default
    }
    /*
     id: 1658,
     videoLinkId: "jBS2PVIhVgM",
     channelId: 1,
     storeId: 1648,
     title: "30명 줄서서 먹는... 한우말이고기..매진될 때까지 먹었습니다!!!",
     registerDateMoobe: "2021-03-11 23:51:21",
     tag: "#한우말이고기 #말이고기 #한우",
     store:
        id: 1648,
        contentsID: 1658,
        name: "산정집",
        tel: "033-742-8556",
        address1: "강원 원주시 천사로 203-15",
        address2: "일산동 217-8",
        availableTime: "매일 12:00 - 14:00점심 매일 14:00 - 17:00Break time 매일 17:30 - 20:30저녁시간 일요일 휴무공휴일 휴무",
        latitude: 37.3515452074584,
        longitude: 127.946080003682,
        link: "https://store.naver.com/restaurants/detail?id=11708672"
     thumbnailUrl: "https://img.youtube.com/vi/jBS2PVIhVgM/0.jpg",
     contentsMetrics:
        videoId: "jBS2PVIhVgM",
        viewCount: 160176,
        likeCount: 4734,
        dislikeCount: 70,
        commentCount: 278,
        updateRegisterDate: "2021-03-25"
     */
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        playerView.layer.masksToBounds = true
        playerView.layer.cornerRadius = 10
        
    }
    //MARK: - Private Method
}

//MARK: - Youtube Play
extension ContentDetailViewController : WKYTPlayerViewDelegate {
    func playerViewDidBecomeReady(_ playerView: WKYTPlayerView) {
        playerView.playVideo()
    }
}
