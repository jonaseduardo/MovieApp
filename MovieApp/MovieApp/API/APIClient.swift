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
    
    let baseUrl = "https://api.themoviedb.org"
    let imageBaseUrl = "https://image.tmdb.org/t/p/"
    let apiVersion: String = "/3"
    typealias RequestResult<T> = Result<T, Failure>
    typealias CompletionHandler<T> = (RequestResult<T>) -> Void

    func get<ResponseType: Decodable>(endPoint: String, parameters: [String : Any]? = nil, completion: @escaping CompletionHandler<ResponseType>) {
        let url = "\(baseUrl)\(apiVersion)/\(endPoint)"

        AF.request(url, parameters: parameters, headers: headers()).validate().responseDecodable(of: ResponseType.self) { response in
            switch response.result {
            case .success(let result):
                completion(.success(result))
            case .failure:
                if let data = response.data {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let genericError = try? decoder.decode(GenericError.self, from: data)
                    completion(.failure(.genericError(genericError)))
                    return
                }
                completion(.failure(.unknownError))
            }
        }
    }
    
    enum Failure: Error {
        case genericError(GenericError?)
        case unknownError
        case invalidImage
    }
    
    struct GenericError: Codable {
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
