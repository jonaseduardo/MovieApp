//
//  HomeViewModel.swift
//  MovieApp
//
//  Created by Jonathan Garcia on 22/06/2020.
//  Copyright © 2020 Jonathan Garcia. All rights reserved.
//

protocol HomeViewModelProtocol {
    var itemCount: Int { get }
}

final class HomeViewModel: HomeViewModelProtocol {
    var itemCount: Int {
        return 3
        
    }
}
