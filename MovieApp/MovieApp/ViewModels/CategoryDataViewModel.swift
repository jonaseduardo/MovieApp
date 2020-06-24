//
//  CategoryDataViewModel.swift
//  MovieApp
//
//  Created by Jonathan Garcia on 23/06/2020.
//  Copyright © 2020 Jonathan Garcia. All rights reserved.
//

protocol CategoryDataViewModelProtocol {
    var movies: Box<[MovieViewModelProtocol]> { get set}
    var categoryName: String { get }
    var itemCount: Int { get }
    
    init(category: Category?)
    func getMovies(page: Int)
    func getMovieViewModel(index: Int) -> MovieViewModelProtocol?
}

final class CategoryDataViewModel: CategoryDataViewModelProtocol {
    var category: Category?
    var apiClient = APIClient()
    var movies: Box<[MovieViewModelProtocol]> = Box([MovieViewModelProtocol]())
    
    var categoryName: String  {
        return category?.name ?? ""
    }
    
    var itemCount: Int {
        return movies.value.count
    }
    
    init(category: Category?) {
        self.category =  category
    }
    
    func getMovies(page: Int) {
        let type = category?.type ?? .popular
        apiClient.getMoviesForCategory(type, page: 0) { result in
            switch result {
            case .success(let movies):
                print(movies)
                self.movies.value = self.createMovieViewModels(movies: movies.items)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getMovieViewModel(index: Int) -> MovieViewModelProtocol? {
        return movies.value[index]
    }
    
    func createMovieViewModels(movies: [Movie]) -> [MovieViewModelProtocol] {
        let viewModels = movies.map { movie in
            MovieViewModel(movie: movie)
        }
        return viewModels
    }
}
