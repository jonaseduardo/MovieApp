//
//  MovieViewModel.swift
//  MovieApp
//
//  Created by Jonathan Garcia on 24/06/2020.
//  Copyright © 2020 Jonathan Garcia. All rights reserved.
//

import UIKit

protocol MovieViewModelProtocol {
    var movie: Movie { get set }
    var movieImage: Box<UIImage> { get set }
    var movieId: String { get }
    init(movie: Movie)
    func loadImage()
}

final class MovieViewModel: MovieViewModelProtocol {
    var movie: Movie
    var movieImage: Box<UIImage> = Box(UIImage())
    
    var movieId: String {
        guard let movieId = movie.id else { return "" }
        return String(movieId)
    }
    
    init(movie: Movie) {
        self.movie = movie
    }
    
    func loadImage() {
        guard let posterPath = movie.posterPath else { return }
        
        APIClient().requestImage(posterPath: posterPath) { result in
            switch result {
            case .success(let image):
                self.movieImage.value = image
            case .failure:
                break
                //self.movieImage.value = UIImage() //
            }
        }
    }
}
