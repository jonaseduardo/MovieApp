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
    var movieImage: Box<UIImage> { get }
    var movieIsLoaded: Box<Bool> { get }
    var video: Box<Video> { get }
    var title: String { get }
    var releaseDate: String { get }
    var homepage: String { get }
    var overview: String { get }
    var voteAverage: String { get }
    
    func getDetailMovie()
}

final class DetailMovieViewModel: DetailMovieViewModelProtocol {
    var movieImage: Box<UIImage> = Box(UIImage())
    var movieIsLoaded: Box<Bool> = Box(false)
    var video: Box<Video> = Box(Video())

    private var movie: DetailMovie?
    private var movieId: String
    private var apiClient: APIClient
    
    init(movieId: String, apiClient: APIClient) {
        self.movieId = movieId
        self.apiClient = apiClient
    }

    func getDetailMovie() {
        apiClient.getDetailMovieForId(id: movieId) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let detailMovie):
                self.movie = detailMovie
                self.movieIsLoaded.value = true
                self.loadImage()
                self.getVideos(movieId: self.movieId)
            case .failure(_):
                break
            }
        }
    }
        
    func loadImage() {
        guard let posterPath = movie?.posterPath else { return }
        
        apiClient.requestImage(posterPath: posterPath) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let image):
                self.movieImage.value = image
            case .failure:
                break
            }
        }
    }
    
    func getVideos(movieId: String) {
        apiClient.getMovieVideos(movieId: movieId) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let videos):
                print(videos)
                if let video = videos.items?.first {
                    self.video.value = video
                }
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
