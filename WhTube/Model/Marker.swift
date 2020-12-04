//
//  marker.swift
//  WhTube
//
//  Created by Terry on 2020/12/03.
//

import Foundation

struct markerResponse : Codable {
    let markerList : [markerLists]
    let markerListSize : Int
}

struct markerLists : Codable {
    let id : Int
    let tag : String
    let name : String
    let latitude: Double
    let longitude : Double
}
