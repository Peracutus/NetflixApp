//
//  APICaller.swift
//  NetflixApp
//
//  Created by Roman on 02.10.2022.
//

import Foundation

struct Constants {
    static let API_KEY = "k_yx96o5uf"
    static let baseURL = "https://imdb-api.com"
}

enum APIError: Error {
    case failedToGetData
}

public final class APICaller {
    static let shared = APICaller()
    
    func getNeedRating(rating: String, complition: @escaping (Result<[MovieDetail], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/en/API/\(rating)/\(Constants.API_KEY)") else { return }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil  else {
                return
            }
            do {
                let results = try JSONDecoder().decode(Movies.self, from: data)
                guard let items = results.items else { return }
                complition(.success(items))
            } catch {
                complition(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
    
    func getNewMoviews(complition: @escaping (Result<[NewMovieDataDetail], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/en/API/ComingSoon/\(Constants.API_KEY)") else { return }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil  else {
                return
            }
            do {
                let results = try JSONDecoder().decode(UpcomingMovies.self, from: data)
                guard let items = results.items else { return }
                complition(.success(items))
            } catch {
                complition(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
}

