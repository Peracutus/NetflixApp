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
                if results.errorMessage != nil {
                    print(results.errorMessage ?? "")
                }
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
    
    func getSearchMovies(expression: String, complition: @escaping (Result<[SearchResult], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/en/API/SearchMovie/\(Constants.API_KEY)/\(expression)") else { return }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil  else {
                return
            }
            do {
                let results = try JSONDecoder().decode(SearchData.self, from: data)
                guard let items = results.results else { return }
                complition(.success(items))
            } catch {
                complition(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
}
//
//    func aPISearchApiKeyExpressionGetWithRequestBuilder(apiKey: String, expression: String) -> RequestBuilder<SearchData> {
//       var path = "/API/Search/{apiKey}/{expression}"
//       let apiKeyPreEscape = "\(apiKey)"
//       let apiKeyPostEscape = apiKeyPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
//       path = path.replacingOccurrences(of: "{apiKey}", with: apiKeyPostEscape, options: .literal, range: nil)
//       let expressionPreEscape = "\(expression)"
//       let expressionPostEscape = expressionPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
//       path = path.replacingOccurrences(of: "{expression}", with: expressionPostEscape, options: .literal, range: nil)
//       let URLString = SwaggerClientAPI.basePath + path
//       let parameters: [String:Any]? = nil
//       let url = URLComponents(string: URLString)
//
//
//       let requestBuilder: RequestBuilder<SearchData>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()
//
//       return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
//   }
//   /**
//
//    - parameter apiKey: (path)
//    - parameter expression: (path)
//    - parameter completion: completion handler to receive the data and the error objects
//    */
//    func aPISearchCompanyApiKeyExpressionGet(apiKey: String, expression: String, completion: @escaping ((_ data: SearchData?,_ error: Error?) -> Void)) {
//       aPISearchCompanyApiKeyExpressionGetWithRequestBuilder(apiKey: apiKey, expression: expression).execute { (response, error) -> Void in
//           completion(response?.body, error)
//       }
//   }



