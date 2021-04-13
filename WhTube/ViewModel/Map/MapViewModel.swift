//
//  MapViewModel.swift
//  WhTube
//
//  Created by Terry on 2021/04/09.
//

import Foundation
import Alamofire
import SwiftyJSON

class MapViewModel {
    
    static let shared = MapViewModel()
    
    func mapListResponse(completion: @escaping (Result<[markerLists]> ) -> Void ){
        
        Alamofire.request(EndPoint.marker)
            .validate(statusCode: 200..<401)
            .responseJSON { (response) in
                guard let responseValue = response.value else { return }
                let resJson = JSON(responseValue)
                var mapList = [markerLists]()
                let Array = resJson
                for (_,subJson): (String,JSON) in Array {
                    let name = subJson["markerList"]["name"].string ?? ""
                    let lat = subJson["markerList"]["latitude"].intValue
                    let lon = subJson["markerList"]["longitude"].intValue
                    let item = markerLists(name: name, latitude: lat, longitude: lon)
                    mapList.append(item)
                }
                if mapList.count > 0 {
                    completion(.success(mapList))
                }else{
                    completion(.failure(Error.self as! Error))
                }
            }
        
    }
}
