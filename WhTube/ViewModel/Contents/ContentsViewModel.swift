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
    
    var channel : [channels] = []
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
    
    var numberOfRowsInSection: Int {
        return content.count
    }
    func selectByContent(at indexPath: IndexPath) -> contents {
        let contents = content[indexPath.row]
        return contents
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
