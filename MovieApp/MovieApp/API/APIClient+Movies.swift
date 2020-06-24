//
//  APIClient+Movies.swift
//  MovieApp
//
//  Created by Jonathan Garcia on 24/06/2020.
//  Copyright © 2020 Jonathan Garcia. All rights reserved.
//

import Alamofire
import AlamofireImage

extension APIClient {
    
    func getMoviesForCategory(_ moviesCategory: MoviesCategory, page: Int, completion: @escaping CompletionHandler<Movies>) {
        let endPoint = "movie/\(moviesCategory.rawValue)"
        let parameters = ["page":page]
        get(endPoint: endPoint, parameters: parameters, completion: completion)
    }
    
    func getDetailMovieForId(id: String, completion: @escaping CompletionHandler<DetailMovie>) {
        let endPoint = "movie/\(id)"
        get(endPoint: endPoint, completion: completion)
    }
    
    func getMovieVideos(movieId: String, completion: @escaping CompletionHandler<Videos>) {
        let endPoint = "movie/\(movieId)/videos"
        get(endPoint: endPoint, completion: completion)
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
}
