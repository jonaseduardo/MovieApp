//
//  DetailMovieViewModel.swift
//  MovieApp
//
//  Created by Jonathan Garcia on 22/06/2020.
//  Copyright © 2020 Jonathan Garcia. All rights reserved.
//

import Alamofire
import AlamofireImage

protocol DetailMovieViewModelProtocol {
    var title: String { get }
    var releaseDate: String { get }
    var homepage: String { get }
    var overview: String { get }
    var voteAverage: Double { get }
}

final class DetailMovieViewModel: DetailMovieViewModelProtocol {
    var movie: DetailMovie?
    
    init(movie: DetailMovie) {
        self.movie = movie
    }
    
    var title: String {
        return movie?.title ?? ""
        
    }
    
    var releaseDate: String {
        return movie?.releaseDate ?? ""
        
    }
    
    var homepage: String {
        return movie?.homepage ?? ""
        
    }
    
    var overview: String {
        return movie?.overview ?? ""
        
    }
    
    var voteAverage: Double {
        return movie?.voteAverage ?? 0
        
    }
    
    func loadImage() {
        guard let url = movie?.posterPath, !url.isEmpty else { return }
        
        AF.request(url).responseImage { response in
            if case .success(let image) = response.result {
            }
        }
    }

}
