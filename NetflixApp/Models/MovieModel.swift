//
//  MovieModel.swift
//  NetflixApp
//
//  Created by Roman on 02.10.2022.
//

import Foundation

public struct Movies: Codable {
    public var items: [MovieDetail]?
    public var errorMessage: String?

    public init(items: [MovieDetail]? = nil, errorMessage: String? = nil) {
        self.items = items
        self.errorMessage = errorMessage
    }
}

public struct MovieDetail: Codable {

    public var _id: String?
    public var rank: String?
    public var rankUpDown: String?
    public var title: String?
    public var fullTitle: String?
    public var year: String?
    public var image: String?
    public var crew: String?
    public var imDbRating: String?
    public var imDbRatingCount: String?

    public init(_id: String? = nil, rank: String? = nil, rankUpDown: String? = nil, title: String? = nil, fullTitle: String? = nil, year: String? = nil, image: String? = nil, crew: String? = nil, imDbRating: String? = nil, imDbRatingCount: String? = nil) {
        self._id = _id
        self.rank = rank
        self.rankUpDown = rankUpDown
        self.title = title
        self.fullTitle = fullTitle
        self.year = year
        self.image = image
        self.crew = crew
        self.imDbRating = imDbRating
        self.imDbRatingCount = imDbRatingCount
    }

    public enum CodingKeys: String, CodingKey {
        case _id = "id"
        case rank
        case rankUpDown
        case title
        case fullTitle
        case year
        case image
        case crew
        case imDbRating
        case imDbRatingCount
    }
}
