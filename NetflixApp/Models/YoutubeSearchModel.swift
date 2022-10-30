//
//  YoutubeSearchModel.swift
//  NetflixApp
//
//  Created by Roman on 30.10.2022.
//

import Foundation

struct YoutubeSearchModel: Codable {
    let items: [VideoElement]
}

struct VideoElement: Codable {
    let id: IdVideoElement
}

struct IdVideoElement: Codable {
    let kind: String
    let videoId: String
}
