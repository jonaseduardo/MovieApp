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
    var movieIsLoaded: Box<Bool> { get set }
    var title: String { get }
    var releaseDate: String { get }
    var homepage: String { get }
    var overview: String { get }
    var voteAverage: String { get }
    init(movieId: String)
    func getDetailMovie()
}

final class DetailMovieViewModel: DetailMovieViewModelProtocol {
    var movieImage: Box<UIImage> = Box(UIImage())
    var movieIsLoaded: Box<Bool> = Box(false)

    private var movie: DetailMovie?
    private var movieId: String
    
    init(movieId: String) {
        self.movieId = movieId
    }

    func getDetailMovie() {
        APIClient().getDetailMovieForId(id: movieId) { [weak self] result in
            switch result {
            case .success(let detailMovie):
                self?.movie = detailMovie
                self?.movieIsLoaded.value = true
                self?.loadImage()
            case .failure(let error):
                break
            }
        }
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

extension DetailMovieViewModel {
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
    
    var voteAverage: String {
        guard let voteAverage = movie?.voteAverage else { return "" }
        return String(voteAverage)
    }
}
