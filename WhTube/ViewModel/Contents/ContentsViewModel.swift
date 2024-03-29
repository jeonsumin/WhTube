//
//  COntentsViewModel.swift
//  WhTube
//
//  Created by Terry on 2020/12/15.
//

import UIKit

typealias Handler = ([contents]) -> Void

class ContentsViewModel {

    var changeHandler : Handler
    
    var channel = [channels]()
    var content: [contents] = [] {
        didSet {
            changeHandler(content)
        }
    }
    init(changeHandler: @escaping Handler) {
        self.changeHandler = changeHandler
    }
}

extension ContentsViewModel {
    func fetchData(){
        
        let channelApi = NetworkManager.init(path: "api/channels", method: .get)
        channelApi.request(success: { response in
            
            let decoder = JSONDecoder()
            let jsondata = try! decoder.decode([channels].self, from: response!)
//            var arr = [channels]()
            for i in jsondata{
                let arrItem = channels(id: i.id, youtubeID:i.youtubeID , youtubeName: i.youtubeID, category: i.category, profileImg: i.profileImg)
                self.channel.append(arrItem)
            }

//            self.channel = jsondata
            
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
    
    var numberOfRowsInSection: Int {
        return content.count
    }
    func selectByContent(at indexPath: IndexPath) -> contents {
        let contents = content[indexPath.row]
        return contents
    }
    func selectedContentChannel(channelId : Int) -> String{
        var channelImage = ""
        for item in channel {
            if item.id == channelId {
                channelImage = item.profileImg
            }
        }
        return channelImage
    }
    func cell(for indexPath: IndexPath,at tableView: UITableView) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath) as? ContentsListCell else {
            return UITableViewCell()
        }
        let contentModel = content[indexPath.row]
        for item in channel {
            if item.id == contentModel.channelId{
                cell.configure(contentModel, item.profileImg)
            }
        }
        
        return cell
    }
}
