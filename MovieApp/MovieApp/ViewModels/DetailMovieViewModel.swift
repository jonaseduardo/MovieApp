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
    var movieImage: Box<UIImage> { get set }
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
    
    var movieImage: Box<UIImage> = Box(UIImage())
    
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
        guard let posterPath = movie?.posterPath else { return }
        
        APIClient().requestImage(posterPath: posterPath) { [weak self] result in
            switch result {
            case .success(let image):
                self?.movieImage.value = image
            case .failure:
                break
            }
        }
    }
}
