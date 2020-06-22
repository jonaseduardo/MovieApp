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
    private let apiVersion: String = "/v3"
    typealias CompletionHandler = () -> ()
    
    func getMovies(moviesCategory: MoviesCategory, page: Int, completion: @escaping CompletionHandler) {
        var endPoint: String
        
        switch moviesCategory {
        case .popular:
            endPoint = "/movie/popular"
        case .topRated:
            endPoint = "/movie/top_rated"
        case .upcoming:
            endPoint = "/movie/upcoming"
        }
        
        let parameters = ["page" : String(page)]
        get(endPoint: endPoint, parameters: parameters, completion: completion)
    }
    
    func get(endPoint: String, parameters: [AnyHashable : Any], completion: @escaping CompletionHandler) {
        let url = "\(baseUrl)\(apiVersion)\(endPoint)"
        
        AF.request(url).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                print(value)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    public enum MoviesCategory {
        case popular
        case topRated
        case upcoming
    }
    
}
