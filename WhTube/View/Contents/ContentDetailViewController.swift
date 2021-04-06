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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        playerView.layer.masksToBounds = true
        playerView.layer.cornerRadius = 10
        
    }
}

//MARK: - Private Method
extension ContentsViewController {
}

//MARK: - Youtube Play
extension ContentDetailViewController : WKYTPlayerViewDelegate {
    func playerViewDidBecomeReady(_ playerView: WKYTPlayerView) {
        playerView.playVideo()
    }
}
