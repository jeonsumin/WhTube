//
//  ContentDetailViewController.swift
//  WhTube
//
//  Created by Terry on 2020/12/02.
//

import UIKit
import YoutubePlayer_in_WKWebView
import MapKit
import Kingfisher

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
    var channlImageURL = ""
    var channel = [channels]()
    
    let distanceSapn:CLLocationDistance = 50000
    
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
        print("channel : \(self.channlImageURL)")
        navigationController?.navigationBar.barStyle = .default
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        playerView.layer.masksToBounds = true
        playerView.layer.cornerRadius = 10
    }
    
    //MARK: - Private Method
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
        viewCount.text = "조회수 \(contentBy.contentsMetrics.viewCount)"
        createDate.text = contentBy.contentsMetrics.updateRegisterDate
        storeName.text = contentBy.store.name
        contentBy.store.availableTime.isEmpty ? (storeTime.text = "저희도몰라요ㅠ") : (storeTime.text = contentBy.store.availableTime)
        storePlace.text = contentBy.store.address1
        contentBy.store.tel.isEmpty ? (storeTelNum.text = "Nan") : (storeTelNum.text = "\(contentBy.store.tel)")
        channelImage.layer.cornerRadius = channelImage.frame.height / 2
        let url = URL(string: channlImageURL)
        channelImage.kf.setImage(with: url)

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
