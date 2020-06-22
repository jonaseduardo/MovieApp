//
//  MovieDetail.swift
//  MovieApp
//
//  Created by Jonathan Garcia on 21/06/2020.
//  Copyright © 2020 Jonathan Garcia. All rights reserved.
//

import Foundation

struct MovieDetail: Codable {
    var id: Int?
    var title: String?
    var releaseDate: String?
    var homepage: String?
    var overview: String?
    var posterPath: String?
    var voteAverage: Double?
}
