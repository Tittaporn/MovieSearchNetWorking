//
//  Movie.swift
//  MovieSearch
//
//  Created by Lee McCormick on 1/29/21.
//

import UIKit

struct TopLevelObject: Decodable {
    let results: [Movie]
}

struct Movie: Decodable {
    let title: String
    let rating: Double
    let summary: String
    let poster: String
    
    enum CodingKeys: String, CodingKey {
        case title
        case rating = "vote_average"
        case summary = "overview"
        case poster = "poster_path"
    }
}

