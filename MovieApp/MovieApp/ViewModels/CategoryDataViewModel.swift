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
    
    func getMovies()
    func getMovieViewModel(index: Int) -> MovieViewModelProtocol?
}

final class CategoryDataViewModel: CategoryDataViewModelProtocol {
    var movies: Box<[MovieViewModelProtocol]> = Box([MovieViewModelProtocol]())
    
    private var category: Category
    private var apiClient: APIClient
    private var currentPage: Int = 1
        
    init(category: Category, apiClient: APIClient) {
        self.category = category
        self.apiClient = apiClient
    }
    
    func getMovies() {
        apiClient.getMoviesForCategory(category.type, page: currentPage) { result in
            switch result {
            case .success(let movies):
                self.currentPage += 1
                let moviesViewModels = self.createMovieViewModels(movies: movies.items)
                self.movies.value = self.movies.value + moviesViewModels
            case .failure(let error):
                print(error)
                self.movies.value = self.movies.value
            }
        }
    }
    
    func getMovieViewModel(index: Int) -> MovieViewModelProtocol? {
        return movies.value[index]
    }
    
    func createMovieViewModels(movies: [Movie]) -> [MovieViewModelProtocol] {
        let viewModels = movies.map { movie in
            MovieViewModel(movie: movie, apiClient: self.apiClient)
        }
        return viewModels
    }
}

extension CategoryDataViewModel {
    var categoryName: String  {
        return category.name
    }
    
    var itemCount: Int {
        return movies.value.count
    }
}
