//
//  Video.swift
//  MovieApp
//
//  Created by Jonathan Garcia on 24/06/2020.
//  Copyright © 2020 Jonathan Garcia. All rights reserved.
//

struct Video: Codable {
    var id: String?
    var name: String?
    var key: String?
    var site: String?
}

struct Videos: Codable {
    var items: [Video]?
    
    private enum CodingKeys: String, CodingKey {
        case items = "results"
    }
}
