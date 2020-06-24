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
    func getMovies()
    func getMovieViewModel(index: Int) -> MovieViewModelProtocol?
}

final class CategoryDataViewModel: CategoryDataViewModelProtocol {
    var category: Category?
    var apiClient = APIClient()
    var movies: Box<[MovieViewModelProtocol]> = Box([MovieViewModelProtocol]())
    
    var currentPage: Int = 1
        
    init(category: Category?) {
        self.category =  category
    }
    
    func getMovies() {
        guard let type = category?.type else { return }
        
        apiClient.getMoviesForCategory(type, page: currentPage) { result in
            switch result {
            case .success(let movies):
                print(movies)
                self.currentPage += 1
                let moviesViewModels = self.createMovieViewModels(movies: movies.items)
                self.movies.value = self.movies.value + moviesViewModels
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

extension CategoryDataViewModel {
    var categoryName: String  {
        return category?.name ?? ""
    }
    
    var itemCount: Int {
        return movies.value.count
    }
}
