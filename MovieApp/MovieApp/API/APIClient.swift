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
            case .failure(let error):
                self.handleError(error: error, data: response.data, completion: completion)
            }
        }
    }
    
    func handleError<T>(error: AFError, data: Data?, completion: @escaping CompletionHandler<T>) {
        guard case let .responseValidationFailed(.unacceptableStatusCode(code)) = error else {
            completion(.failure(.timeout(message: error.errorDescription)))
            return
        }
        
        switch code {
        case 400...499:
            if let data = data {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let apiError = try? decoder.decode(ApiError.self, from: data)
                if let apiError = apiError {
                    completion(.failure(.apiError(apiError)))
                } else {
                    completion(.failure(.customError(data)))
                }
                
                return
            }
        case 500...599:
            completion(.failure(.serverError(message: error.localizedDescription)))
        default:
            completion(.failure(.unknown(message: error.errorDescription)))
        }
    }
    
    enum Failure: Error {
        case apiError(ApiError?)
        case customError(Data?)
        case timeout(message: String?)
        case serverError(message: String?)
        case unknown(message: String?)
        case invalidImage
    }
    
    struct ApiError: Codable {
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
