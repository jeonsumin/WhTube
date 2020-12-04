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
    let thumbnailUrl: String
    let contentsMetrics: contentsMetrics
}

struct contentsMetrics : Codable {
    let videoId: String
    let viewCount: Int
    let likeCount: Int
    let dislikeCount: Int
    let commentCount: Int
    let updateRegisterDate: String
}
