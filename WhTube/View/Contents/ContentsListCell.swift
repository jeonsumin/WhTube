//
//  ContentsListCell.swift
//  WhTube
//
//  Created by Terry on 2020/12/15.
//

import UIKit

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
