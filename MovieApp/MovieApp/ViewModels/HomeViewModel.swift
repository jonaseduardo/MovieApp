//
//  HomeViewModel.swift
//  MovieApp
//
//  Created by Jonathan Garcia on 22/06/2020.
//  Copyright © 2020 Jonathan Garcia. All rights reserved.
//

protocol HomeViewModelProtocol {
    var categories: [Category] { get }
    var itemCount: Int { get }
    
    func getCategory(index: Int) -> Category
}

final class HomeViewModel: HomeViewModelProtocol {
    let categories: [Category]
    var itemCount: Int {
        return categories.count
    }
    
    init() {
        categories = [Category(name: "Popular", type: MoviesCategory.popular),
                      Category(name: "Top Rated", type: MoviesCategory.topRated),
                      Category(name: "Upcoming", type: MoviesCategory.upcoming)]
    }
    
    func getCategory(index: Int) -> Category {
        return categories[index]
    }
}
