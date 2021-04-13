//
//  marker.swift
//  WhTube
//
//  Created by Terry on 2020/12/03.
//

import Foundation

struct markerResponse : Codable {
    let Lists : [markerLists]
    let markerListSize : Int
    let centerLatitude : Double
    let centerLongitude : Double
    enum CodingKeys: String, CodingKey {
        case Lists = "markerList"
        case markerListSize,centerLatitude,centerLongitude
    }
}

struct markerLists : Codable {
    let id : Int
    let tag : String
    let name : String
    let latitude: Double
    let longitude : Double
    
    enum CodingKeys: String, CodingKey {
        case id, tag, name, latitude, longitude
    }
}
