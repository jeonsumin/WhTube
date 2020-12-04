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
    
    //MARK: - Channel
    static func channelRequest(completion: @escaping ([channels]) -> Void){
        let channelRequesturl = URL(string: "https://moobe.co.kr/api/channels")!
        /*
        URLSession.shared.dataTask(with: channelRequesturl) { (data, response, error) in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let responseData = data else { return }
            
            let decoder = JSONDecoder()
            do{
                let channel = try decoder.decode([channels].self, from: responseData)
                completion(.success(channel))
            }catch{
                print("decode error ::: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }.resume()
        */
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
    func markerRequest(){
        let markerRequestUrl = URL(string: "https://moobe.co.kr/api/cluster")!
        URLSession.shared.dataTask(with: markerRequestUrl) { (data, response, error) in
            guard error == nil,
                  let responseData = data else { return }
            
            let decode = JSONDecoder()
            do{
                let markerData = try decode.decode([markerResponse].self, from: responseData)
                print("markderData ::: \(markerData.count)")
            }catch{
                print("marker Error ::: \(error.localizedDescription)")
            }
            
        }.resume()
    }
    
    //MARK: - Contents
    func contentsRequest(){
        let contentsRequsetUrl = URL(string: "https://moobe.co.kr/api/contents?page=1")!
        
        URLSession.shared.dataTask(with: contentsRequsetUrl) { data, reponse, error in
            guard error == nil,
                  let contentsData = data else {
                return
            }
            
            let StringData = String(data: contentsData, encoding: .utf8)
            print("Stringdata :: \(StringData) ")
            
            let decoder = JSONDecoder()
            do{
                let json = try decoder.decode(contentResponse.self, from: contentsData)
                print("contents JSON ::: \(json.contents.first)")
            }catch{
                print("error ::: \(error.localizedDescription)")
            }
        }.resume()
    }
}
