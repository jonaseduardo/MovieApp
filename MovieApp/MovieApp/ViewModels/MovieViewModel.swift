//
//  MovieViewModel.swift
//  MovieApp
//
//  Created by Jonathan Garcia on 24/06/2020.
//  Copyright © 2020 Jonathan Garcia. All rights reserved.
//

import UIKit

protocol MovieViewModelProtocol {
    var movie: Movie { get }
    var movieImage: Box<UIImage> { get }
    var movieId: String { get }
    func loadImage()
}

final class MovieViewModel: MovieViewModelProtocol {
    var movie: Movie
    var movieImage: Box<UIImage> = Box(UIImage())
    private var apiClient: APIClient
    
    var movieId: String {
        guard let movieId = movie.id else { return "" }
        return String(movieId)
    }
    
    init(movie: Movie, apiClient: APIClient) {
        self.movie = movie
        self.apiClient = apiClient
    }
    
    func loadImage() {
        guard let posterPath = movie.posterPath else { return }
        
        apiClient.requestImage(posterPath: posterPath) { result in
            switch result {
            case .success(let image):
                self.movieImage.value = image
            case .failure:
                break
            }
        }
    }
}
