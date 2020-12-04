//
//  Channel.swift
//  WhTube
//
//  Created by Terry on 2020/12/03.
//

import Foundation

struct channels: Codable {
    let id: Int
    let youtubeID, youtubeName: String
    let category: String
    let profileImg: String

    enum CodingKeys: String, CodingKey {
        case id
        case youtubeID = "youtubeId"
        case youtubeName, category, profileImg
    }
}
