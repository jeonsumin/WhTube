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
    
    var channel : [channels] = []
    
    var content: [contents] = [] {
        didSet {
            DispatchQueue.main.async {
                self.table.reloadData()
            }
        }
    }
    //MARK: - LifeCycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let channelApi = NetworkManager.init(path: "api/channels", method: .get)
        channelApi.request(success: { response in
            
            let decoder = JSONDecoder()
            let jsondata = try! decoder.decode([channels].self, from: response!)
            self.channel = jsondata
        }, fail: { error in
            print("error :: \(String(describing: error))")
        })
        
         let contentApi = NetworkManager.init(path: "api/contents", method: .get)
         contentApi.request { response in
            let decoder = JSONDecoder()
            let jsonData = try! decoder.decode(contentResponse.self, from: response!)
            self.content = jsonData.contents
            
        } fail: { (error) in
            print("error::: \(String(describing: error))")
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}
//MARK: - TableView
extension ContentsViewController: UITableViewDataSource{
    
    //TODO: 셀 개수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return content.count
    }
    
    //TODO: 셀 데이터
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ContentsListCell else {
            return UITableViewCell()
        }
//        cell.backgroundColor = UIColor.randomColor()
        
        let contentModel = content[indexPath.row]
        for item in channel {
            if item.id == contentModel.channelId{
                cell.configure(contentModel, item.profileImg)
            }
        }
        
        return cell
    }
    
}

extension ContentsViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let contentsDetailVC = storyboard?.instantiateViewController(identifier: "ContentDetailViewController") as! ContentDetailViewController
        navigationController?.pushViewController(contentsDetailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 340
    }
}
//MARK: - TableView Cell
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
        channelThumbImg.layer.masksToBounds = true
    }
}
