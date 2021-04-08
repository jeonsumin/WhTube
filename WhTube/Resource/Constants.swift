//
//  Constants.swift
//  WhTube
//
//  Created by Terry on 2020/12/14.
//

import Foundation

struct Constants {
    static let API_URL = "https://moobe.co.kr/"
}

enum customError:String,Error {
    case failAPI = "API 호출 실패"
}
