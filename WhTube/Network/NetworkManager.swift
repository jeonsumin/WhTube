//
//  NetworkManager.swift
//  WhTube
//
//  Created by Terry on 2020/12/03.
//

import UIKit
import Alamofire

// Alamofire를 활용한 NetworkManager
class NetworkManager {
    
    static let shared : NetworkManager = NetworkManager()
    //MARK: - Channel
    func channelRequest(completion: @escaping ([channels]) -> Void){
        let channelRequesturl = URL(string: "https://moobe.co.kr/api/channels")!
        Alamofire.request(channelRequesturl, method: .get, parameters: [:], encoding: URLEncoding.default)
            .validate(statusCode: 200..<300)
            .responseJSON { (response) in
                if let jsonData = response.result.value {
                    do{
                        let data = try JSONSerialization.data(withJSONObject: jsonData, options: .prettyPrinted)
                        
                        let decoder = JSONDecoder()
                        let channelJSONData = try decoder.decode([channels].self, from: data)
                        completion(channelJSONData)
                    }catch{
                        
                    }
                }
            }
    }
    
    //MARK: - Marker
    func markerRequest(completion : @escaping ([markerResponse]) -> Void ){
        let markerRequestUrl = URL(string: "https://moobe.co.kr/api/cluster")!
        Alamofire.request(markerRequestUrl, method: .get, parameters: [:], encoding: URLEncoding.default)
            .validate(statusCode: 200..<300)
            .responseJSON { (response) in
                if let responseData = response.result.value {
                    do{
                        let JSONData = try JSONSerialization.data(withJSONObject: responseData, options: .prettyPrinted)
                        let decoder = JSONDecoder()
                        let markderJson = try decoder.decode([markerResponse].self, from: JSONData)
                        completion(markderJson)
                    }catch{
                        print("markder json Decoding fail ")
                    }
                }
            }
    }
    
    //MARK: - Contents
    func contentsRequest(completion: @escaping (contentResponse) -> Void){
        let contentsRequsetUrl = URL(string: "https://moobe.co.kr/api/contents?page=1")!
        Alamofire.request(contentsRequsetUrl, method: .get, parameters: [:], encoding: URLEncoding.default)
            .validate()
            .responseJSON { (response) in
                switch response.result {
                case .success(let value):
                    do{
                    let decoder = JSONDecoder()
                    let data = try JSONSerialization.data(withJSONObject: value, options: .prettyPrinted)
                    let contensJson = try decoder.decode(contentResponse.self, from: data)
                    completion(contensJson)
                    }catch(let err){
                        print("contens json error ::: \(err.localizedDescription)")
                    }
                case .failure(let error):
                    print("contents error :: \(error.localizedDescription)")
                }
            }
    }
    
}
