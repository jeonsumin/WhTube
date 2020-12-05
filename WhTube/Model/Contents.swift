//
//  Contents.swift
//  WhTube
//
//  Created by Terry on 2020/12/03.
//

import Foundation

struct contentResponse: Codable {
    let contents: [contents]
}

struct contents:Codable {
    let id : Int
    let videoLinkId: String
    let channelId: Int
    let storeId: Int
    let title: String
    let registerDateMoobe: String
    let tag: String
    let store: Store
    let thumbnailUrl: String
    let contentsMetrics: contentsMetrics
}
// MARK: - Store
struct Store: Codable {
    let id, contentsID: Int
    let name, tel, address1, address2: String
    let availableTime: String
    let latitude, longitude: Double
    let link: String

    enum CodingKeys: String, CodingKey {
        case id
        case contentsID = "contentsId"
        case name, tel, address1, address2, availableTime, latitude, longitude, link
    }
}

struct contentsMetrics : Codable {
    let videoId: String
    let viewCount: Int
    let likeCount: Int
    let dislikeCount: Int
    let commentCount: Int
    let updateRegisterDate: String
}


