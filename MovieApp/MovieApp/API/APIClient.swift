//
//  APIClient.swift
//  MovieApp
//
//  Created by Jonathan Garcia on 21/06/2020.
//  Copyright © 2020 Jonathan Garcia. All rights reserved.
//

import Alamofire
import AlamofireImage

final class APIClient {
    
    private let baseUrl = "https://api.themoviedb.org"
    private let imageBaseUrl = "https://image.tmdb.org/t/p/"
    private let apiVersion: String = "/3"
    typealias RequestResult<T> = Result<T, Failure>
    typealias CompletionHandler<T> = (RequestResult<T>) -> Void
    
    func getMoviesForCategory(_ moviesCategory: MoviesCategory, page: Int, completion: @escaping CompletionHandler<Movies>) {
        let endPoint = "movie/\(moviesCategory.rawValue)"
        let parameters = ["page":page]
        get(endPoint: endPoint, parameters: parameters, completion: completion)
    }
    
    func get<ResponseType: Decodable>(endPoint: String, parameters: [String : Any], completion: @escaping CompletionHandler<ResponseType>) {
        let url = "\(baseUrl)\(apiVersion)/\(endPoint)"

        AF.request(url, parameters: parameters, headers: headers()).validate().responseDecodable(of: ResponseType.self) { response in
            switch response.result {
            case .success(let result):
                completion(.success(result))
            case .failure:
                if let data = response.data {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let customError = try? decoder.decode(ServerError.self, from: data)
                    completion(.failure(.serverError(customError)))
                    return
                }
                completion(.failure(.unknownError))
            }
        }
    }
    
    func requestImage(posterPath: String, size: String = "w200", completion: @escaping CompletionHandler<UIImage>) {
        let url = "\(imageBaseUrl)\(size)/\(posterPath)"
        
        AF.request(url).responseImage { response in
            switch response.result {
            case .success(let image):
                completion(.success(image))
            case .failure:
                completion(.failure(.invalidImage))
            }
        }
    }
    
    enum Failure: Error {
        case serverError(ServerError?)
        case unknownError
        case invalidImage
    }
    
    struct ServerError: Codable {
        var statusCode: Int?
        var statusMessage: String?
    }
}

extension APIClient {
    
    func headers() -> HTTPHeaders {
        let authorizationValue = "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI2NzQ2MWUxMmFhNTg3NmJmNDI4YjAyOGRlMTdmYjdjOCIsInN1YiI6IjVlZWZkN2Q4NDE0MjkxMDAzMjZiZmQwNiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.AZwpBLpxtzDiYjZdSypyW6accYpajgTOueCGLmAGEls"
            
        let headers: HTTPHeaders = [
            "Authorization": authorizationValue,
        ]
        
        return headers
    }
}

public enum MoviesCategory: String {
    case popular
    case topRated = "top_rated"
    case upcoming
}
