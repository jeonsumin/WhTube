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
    
    @IBOutlet weak var channelImage : UIImageView!
    @IBOutlet weak var lbTitle      : UILabel!
    @IBOutlet weak var viewCount    : UILabel!
    @IBOutlet weak var createDate   : UILabel!
    @IBOutlet weak var storeName    : UILabel!
    @IBOutlet weak var storeTelNum  : UILabel!
    @IBOutlet weak var storePlace   : UILabel!
    @IBOutlet weak var storeTime    : UILabel!
    
    let playerVersion = ["playsinline":1]
    
    var contentBy : contents!
    
    let distanceSapn:CLLocationDistance = 70000
    //MARK: - LifeCycel
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.prefersLargeTitles = false
        playerView.load(withVideoId: contentBy.videoLinkId, playerVars :playerVersion)
        playerView.delegate = self
        fetchData()
        setupLabelTap()
        fetchMap(contentBy)
        
        navigationController?.navigationBar.barStyle = .default
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        playerView.layer.masksToBounds = true
        playerView.layer.cornerRadius = 10
    }
    
    //MARK: - Private Method
    func zoomLevel(location: CLLocation){
        
    }
    func fetchMap(_ place:contents){
        let annotations = MKPointAnnotation()
        annotations.title = place.store.name
        annotations.coordinate = CLLocationCoordinate2D(latitude: place.store.latitude, longitude: place.store.longitude)
        let mapCoordinates = MKCoordinateRegion(center: annotations.coordinate, latitudinalMeters: distanceSapn, longitudinalMeters: distanceSapn)
        map.setRegion(mapCoordinates, animated: true)
        map.addAnnotation(annotations)
        map.scalesLargeContentImage = true
    }
    
    func fetchData(){
        lbTitle.text = contentBy.title
        viewCount.text = "\(contentBy.contentsMetrics.viewCount)"
        createDate.text = contentBy.contentsMetrics.updateRegisterDate
        storeName.text = contentBy.store.name
        storeTime.text = contentBy.store.availableTime
        storePlace.text = contentBy.store.address1
        storeTelNum.text = "\(contentBy.store.tel)"
        //TODO: channel api 호출하여서 채널이미지 보여주기
        //        channelImage.image = contentBy.channelId
        
        channelImage.layer.cornerRadius = channelImage.frame.height / 2
    }
    
    func setupLabelTap(){
        let labelTap = UITapGestureRecognizer(target: self, action: #selector(didTappedLabel(_:)))
        self.storeTelNum.isUserInteractionEnabled = true
        self.storeTelNum.addGestureRecognizer(labelTap)
    }
    
    @objc func didTappedLabel(_ sender: UITapGestureRecognizer){
        let phonNum = contentBy.store.tel.replacingOccurrences(of: "-", with: "")
        if let NumberUrl = URL(string: "tel://\(phonNum)") {
            let application: UIApplication = UIApplication.shared
            if(application.canOpenURL(NumberUrl as URL)){
                application.open(NumberUrl as URL,options: [:], completionHandler: nil)
            }
        }
    }
    //TODO:공통함수로 앱 호출 하기
    func callMapApplication(mapApp mapName:String,openScheme scheme:String){
        
    }
    //MARK:- IBAction Methods
    @IBAction func didTappedMapButton(_ sender: UIButton) {
        let actionSheet = UIAlertController(title: nil, message: "다른 앱으로 보기", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "카카오맵", style: .default, handler: {  _ in
            print("카카오맵 호출")
        }))
        actionSheet.addAction(UIAlertAction(title: "T맵", style: .default, handler: { _ in
            print("T맵 호출")
        }))
        actionSheet.addAction(UIAlertAction(title: "네이버지도", style: .default, handler: { _ in
            print("네이버지도 호출")
        }))
        actionSheet.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        present(actionSheet, animated: true)
    }
}

//MARK: - Youtube Play
extension ContentDetailViewController : WKYTPlayerViewDelegate {
    func playerViewDidBecomeReady(_ playerView: WKYTPlayerView) {
        playerView.playVideo()
    }
}
