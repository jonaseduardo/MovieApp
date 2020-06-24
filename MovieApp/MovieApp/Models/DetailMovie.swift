//
//  DetailMovie.swift
//  MovieApp
//
//  Created by Jonathan Garcia on 21/06/2020.
//  Copyright © 2020 Jonathan Garcia. All rights reserved.
//

struct DetailMovie: Codable {
    var id: Int?
    var title: String?
    var releaseDate: String?
    var homepage: String?
    var overview: String?
    var posterPath: String?
    var voteAverage: Double?
    
    private enum CodingKeys: String, CodingKey {
        case id, title, homepage, overview
        case releaseDate = "release_date"
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
    }
}
