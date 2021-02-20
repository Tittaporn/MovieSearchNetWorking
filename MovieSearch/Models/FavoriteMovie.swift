//
//  FavoriteMovie.swift
//  MovieSearch
//
//  Created by Lee McCormick on 2/20/21.
//

import Foundation

class FavoriteMovie: Codable {
    let title: String
    let rating: Double
    let summary: String
    let poster: String
    var isFavorite: Bool
    
    init(title: String, rating: Double, summary: String, poster: String, isFavorite: Bool = true){
        self.title = title
        self.rating = rating
        self.summary = summary
        self.poster = poster
        self.isFavorite = isFavorite
    }
}

extension FavoriteMovie: Equatable {
    static func == (lhs: FavoriteMovie, rhs: FavoriteMovie) -> Bool {
        lhs.title == rhs.title && lhs.rating == rhs.rating && lhs.summary == lhs.summary
    }
}

