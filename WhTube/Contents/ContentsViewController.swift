//
//  ContentsViewController.swift
//  WhTube
//
//  Created by Terry on 2020/12/02.
//

import UIKit
import Kingfisher

class ContentsViewController: UIViewController {

    @IBOutlet weak var table: UITableView!
    
    
    var contentsReqeust : [contents] = [] {
        didSet {
            DispatchQueue.main.async {
                self.table.reloadData()
            }
        }
    }
    
    var channel : [channels] = [] {
        didSet {
            DispatchQueue.main.async {
                self.table.reloadData()
            }
            
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
        NetworkManager.shared.contentsRequest { response in
            print("count :: \(response.contents.count)")
            self.contentsReqeust = response.contents
        }
        
        NetworkManager.shared.channelRequest { result in
            self.channel = result
        }
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        print("viewDidAppear")
    }
}

extension ContentsViewController: UITableViewDataSource{
    
    //TODO: 셀 개수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contentsReqeust.count
//        return 10
    }
    
    //TODO: 셀 데이터
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ContentsListCell

        let info = contentsReqeust[indexPath.row]
        for item in channel{
            if item.id == info.channelId{
                cell.configure(info, item.profileImg)
            }
        }
//        cell.configure(info)
        return cell
    }
    
}

extension ContentsViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let contentsDetailVC = storyboard?.instantiateViewController(identifier: "ContentDetailViewController") as! ContentDetailViewController
        contentsDetailVC.videoId = contentsReqeust[indexPath.row].videoLinkId
        navigationController?.pushViewController(contentsDetailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 340
    }
}

class ContentsListCell: UITableViewCell {
    
    @IBOutlet weak var videoThumbnailImg: UIImageView!
    @IBOutlet weak var channelThumbImg: UIImageView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var viewCount: UILabel!
    @IBOutlet weak var updateDate: UILabel!
    
    func configure(_ info : contents,_ channel: String ){
        
        let videourl = URL(string: info.thumbnailUrl)
        videoThumbnailImg.kf.setImage(with: videourl)
        
        let channelThumbUrl = URL(string: channel)
        channelThumbImg.kf.setImage(with: channelThumbUrl)
        lbTitle.text = info.title
        viewCount.text = "조회수 \(info.contentsMetrics.viewCount)"
        
        updateDate.text = info.contentsMetrics.updateRegisterDate
    }
    override func awakeFromNib() {
        channelThumbImg.layer.cornerRadius = 20
        channelThumbImg.contentMode = .scaleToFill
    }
}
