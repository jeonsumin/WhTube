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

    let host = Constants.API_URL
    let url: String
    let method : HTTPMethod
    let parameters: Parameters
    var headers : HTTPHeaders? = nil
    
    init(path: String, method: HTTPMethod, parameters: Parameters){
        url = host + path
        self.method = method
        self.parameters = parameters
        self.headers = nil
    }
    
    init(path: String, method: HTTPMethod){
        url = host + path
        self.method = method
        self.parameters = ["":""]
        self.headers = nil
    }
    
    func request(success: @escaping(_ data: Data?) -> Void, fail: @escaping (_ error : Error?) -> Void) {
        Alamofire.request(url, method: method, parameters: parameters )
            .validate()
            .responseData { response in
                switch response.result {
                case .success(let value):
//                    let data = String(data: value, encoding: .utf8)
                    success(value)
                case .failure(let error):
                    fail(error)
                }
            }
    }


}
