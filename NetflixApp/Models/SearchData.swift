//
//  SearchData.swift
//  NetflixApp
//
//  Created by Roman on 16.10.2022.
//

import Foundation

//MARK: - Search data model
public struct SearchData: Codable {

    public var searchType: String
    public var expression: String
    public var results: [SearchResult]?
    public var errorMessage: String?

    public init(searchType: String, expression: String, results: [SearchResult]? = nil, errorMessage: String? = nil) {
        self.searchType = searchType
        self.expression = expression
        self.results = results
        self.errorMessage = errorMessage
    }
}

//MARK: - serach result model
public struct SearchResult: Codable {

    public var _id: String?
    public var resultType: String?
    public var image: String?
    public var title: String?
    public var _description: String?

    public init(_id: String? = nil, resultType: String? = nil, image: String? = nil, title: String? = nil, _description: String? = nil) {
        self._id = _id
        self.resultType = resultType
        self.image = image
        self.title = title
        self._description = _description
    }
}
