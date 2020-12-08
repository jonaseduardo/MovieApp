//
//  Movie.swift
//  MovieApp
//
//  Created by Jonathan Garcia on 21/06/2020.
//  Copyright © 2020 Jonathan Garcia. All rights reserved.
//

struct Movie: Codable {
    var id: Int?
    var title: String?
    var posterPath: String?
    
    private enum CodingKeys: String, CodingKey {
        case id, title
        case posterPath = "poster_path"
    }
}

struct Movies: Codable {
    let items: [Movie]
    
    private enum CodingKeys: String, CodingKey {
        case items = "results"
    }
}

public enum MoviesCategory: String {
    case popular
    case topRated = "top_rated"
    case upcoming
}
