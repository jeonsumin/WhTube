//
//  MapViewModel.swift
//  WhTube
//
//  Created by Terry on 2021/04/09.
//

import Foundation
import Alamofire
import SwiftyJSON

typealias mapHandler = ([markerResponse]) -> Void

class MapViewModel {
    var changehandler : mapHandler
    var map : [markerResponse] = [] {
        didSet{
            changehandler(map)
        }
    }
    
    init(changehandler: @escaping mapHandler) {
        self.changehandler = changehandler
    }
    func MapfetchData(){
        let mapAPI = NetworkManager.init(path: "api/cluster", method: .get)
        mapAPI.request(success: {response in
            let decoder = JSONDecoder()
            let jsondata = try! decoder.decode([markerResponse].self, from: response!)
            self.map = jsondata
        }, fail: {error in
            print("error \(String(describing: error))")
        })
    }
}
