//
//  ChannelViewController.swift
//  WhTube
//
//  Created by Terry on 2020/12/02.
//

import UIKit
import Kingfisher

class ChannelViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - LifeCycle
    var channel : [channels] = [] {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    var content: [contents] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        tableView.dataSource = self
        tableView.delegate = self
        
        
        let channelApi = NetworkManager.init(path: "api/channels", method: .get)
        channelApi.request(success: { response in
            
            let decoder = JSONDecoder()
            let jsondata = try! decoder.decode([channels].self, from: response!)
            self.channel = jsondata
        }, fail: { error in
            print("error :: \(String(describing: error))")
        })
        
         let contentApi = NetworkManager.init(path: "api/contents", method: .get)
        contentApi.request(success: { response in
               let decoder = JSONDecoder()
                     let jsonData = try! decoder.decode(contentResponse.self, from: response!)
                     self.content = jsonData.contents
                     
        }) { (error) in
            print("error::: \(String(describing: error))")
        }
    }
    
}

//MARK: - CollectionView
extension ChannelViewController: UICollectionViewDataSource {
    //TODO: collectionView 아이템 개수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return channel.count
    }
    
    //TODO: colectionView 데이터
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! CollectChannelListCell
        
//        cell.backgroundColor = UIColor.randomColor()
        let info = channel[indexPath.row]
        cell.configCell(info)
        return cell
    }
    
    
}

extension ChannelViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //TODO: 채널 클릭시 해당 채널의 비디오 리스트로 reload 하기
        let channelId = channel[indexPath.row].id
        
        var param = [String:Any]()
        param["channel"] = channelId
        let contentApi = NetworkManager.init(path: "api/contents", method: .get,parameters: param)
        contentApi.request(success: { response in
            let decoder = JSONDecoder()
            let jsonData = try! decoder.decode(contentResponse.self, from: response!)
            self.content = jsonData.contents
        }) { error in
            print("error::: \(String(describing: error))")
        }
    }
}

extension ChannelViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 50, height: 50)
    }
}

class CollectChannelListCell: UICollectionViewCell {
    @IBOutlet weak var thumbnailImg: UIImageView!
    
    func configCell(_ info: channels){
        let Img = info.profileImg
        let url = URL(string: Img)
        thumbnailImg.kf.setImage(with: url)
    }
    
    override func awakeFromNib() {
        thumbnailImg.layer.masksToBounds = true
        thumbnailImg.layer.cornerRadius = 25
    }
}
//MARK: - TableView


extension ChannelViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return content.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath) as? TableChannelListCell else {
            return UITableViewCell()
        }
//        cell.backgroundColor = UIColor.randomColor()
        
        let contentModel = content[indexPath.row]
        for item in channel {
            if item.id == contentModel.channelId{
                cell.config(item.profileImg, contentModel)
            }
        }
        return cell
    }
    
    
}

extension ChannelViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = storyboard?.instantiateViewController(identifier: "ContentDetailViewController") as! ContentDetailViewController
        let content = self.content[indexPath.row]
        detailVC.contentBy = content
        let contentModel = self.content[indexPath.row]
        for item in channel {
            if item.id == contentModel.channelId{
                detailVC.channlImageURL = item.profileImg
            }
        }
        
        navigationController?.pushViewController(detailVC, animated: true)
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 340
    }
    
}

class TableChannelListCell: UITableViewCell{
    @IBOutlet weak var videoThumbnailImg: UIImageView!
    @IBOutlet weak var channelThumbImg: UIImageView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var viewCount: UILabel!
    @IBOutlet weak var updateDate: UILabel!
    
    func config(_ channel: String,_ channelContent: contents) {
        let videoThumbnailUrl = URL(string: channelContent.thumbnailUrl)!
        let channelThumbnailUrl = URL(string: channel)!
        
        videoThumbnailImg.kf.setImage(with: videoThumbnailUrl)
        channelThumbImg.kf.setImage(with: channelThumbnailUrl)
        lbTitle.text = channelContent.title
        viewCount.text = "조회수 \(channelContent.contentsMetrics.viewCount)"
        updateDate.text = channelContent.contentsMetrics.updateRegisterDate
    }
    override func awakeFromNib() {
        channelThumbImg.layer.cornerRadius = 20
        channelThumbImg.layer.masksToBounds = true
    }
}
