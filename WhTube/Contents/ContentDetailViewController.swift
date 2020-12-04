//
//  ContentDetailViewController.swift
//  WhTube
//
//  Created by Terry on 2020/12/02.
//

import UIKit
import YoutubePlayer_in_WKWebView

class ContentDetailViewController: UIViewController {

    @IBOutlet weak var playerView: WKYTPlayerView!
    @IBOutlet weak var playInfoView: UIView!
    
    let playerVersion = ["playsinline":1]
 
    //MARK: - LifeCycel
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        playerView.load(withVideoId: "EvzKLl7zwRw", playerVars :playerVersion)
        playerView.delegate = self
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        playerView.layer.masksToBounds = true
        playerView.layer.cornerRadius = 10
        
        playInfoView.layer.masksToBounds = false
        playInfoView.layer.cornerRadius = 10
        
        playInfoView.layer.shadowOpacity = 0.5
        playInfoView.layer.shadowOffset = CGSize(width: 0, height: 0)
        playInfoView.layer.shadowRadius = 10
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
