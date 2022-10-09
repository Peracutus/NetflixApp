//
//  UpcomingMovies.swift
//  NetflixApp
//
//  Created by Roman on 09.10.2022.
//

import Foundation

public struct UpcomingMovies: Codable {
    
    public var items: [NewMovieDataDetail]?
    public var errorMessage: String?
    
    public init(items: [NewMovieDataDetail]? = nil, errorMessage: String? = nil) {
        self.items = items
        self.errorMessage = errorMessage
    }
}

public struct NewMovieDataDetail: Codable {
    
    public var _id: String?
    public var title: String?
    public var fullTitle: String?
    public var year: String?
    public var releaseState: String?
    public var image: String?
    public var runtimeMins: String?
    public var runtimeStr: String?
    public var plot: String?
    public var contentRating: String?
    public var imDbRating: String?
    public var imDbRatingCount: String?
    public var metacriticRating: String?
    public var genres: String?
    //   public var genreList: [KeyValueItem]?
    public var directors: String?
    //    public var directorList: [StarShort]?
    public var stars: String?
    //    public var starList: [StarShort]?
    
    public init(_id: String? = nil,
                title: String? = nil,
                fullTitle: String? = nil,
                year: String? = nil,
                releaseState: String? = nil,
                image: String? = nil,
                runtimeMins: String? = nil,
                runtimeStr: String? = nil,
                plot: String? = nil,
                contentRating: String? = nil,
                imDbRating: String? = nil,
                imDbRatingCount: String? = nil,
                metacriticRating: String? = nil,
                genres: String? = nil,
                directors: String? = nil,
                stars: String? = nil) {
        self._id = _id
        self.title = title
        self.fullTitle = fullTitle
        self.year = year
        self.releaseState = releaseState
        self.image = image
        self.runtimeMins = runtimeMins
        self.runtimeStr = runtimeStr
        self.plot = plot
        self.contentRating = contentRating
        self.imDbRating = imDbRating
        self.imDbRatingCount = imDbRatingCount
        self.metacriticRating = metacriticRating
        self.genres = genres
        //        self.genreList = genreList
        self.directors = directors
        //        self.directorList = directorList
        self.stars = stars
        //        self.starList = starList
    }
    
    public enum CodingKeys: String, CodingKey {
        case _id = "id"
        case title
        case fullTitle
        case year
        case releaseState
        case image
        case runtimeMins
        case runtimeStr
        case plot
        case contentRating
        case imDbRating
        case imDbRatingCount
        case metacriticRating
        case genres
        //        case genreList
        case directors
        //        case directorList
        case stars
        //        case starList
    }
    
}
