//
//  FavoriteMovieController.swift
//  MovieSearch
//
//  Created by Lee McCormick on 2/20/21.
//

import Foundation

class FavoriteMovieController {
    static let shared = FavoriteMovieController()
    var favoriteMovies: [FavoriteMovie] = []
    
    func createFavoriteMovie(movie: Movie) {
        let newFavoriteMovie = FavoriteMovie(title: movie.title, rating: movie.rating, summary: movie.summary, poster: movie.poster)
        favoriteMovies.append(newFavoriteMovie)
        let newArrayFavoriteMovies = favoriteMovies.removeDuplicates()
        favoriteMovies = []
        favoriteMovies.append(contentsOf: newArrayFavoriteMovies)
        saveToPersistence()
    }
    
    func deleteMovieFromFavoriteListsWith(movie: Movie) {
        for favoriteMovie in favoriteMovies {
            if favoriteMovie.title == movie.title && favoriteMovie.rating == movie.rating && favoriteMovie.summary == movie.summary {
                guard let index = favoriteMovies.firstIndex(of: favoriteMovie) else {return}
                favoriteMovies.remove(at: index)
            } 
        }
        saveToPersistence()
    }
    
    func deleteFavoriteMovieWith(favoriteMovie: FavoriteMovie) {
        guard let index = favoriteMovies.firstIndex(of: favoriteMovie) else {return}
        favoriteMovies.remove(at: index)
        saveToPersistence()
    }
    
    // MARK: - Persistence
    // CREATE
    func createFileForPersistence() -> URL {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileURL = urls[0].appendingPathComponent("SearchMovie.json")
        return fileURL
    }
    
    // SAVE
    func saveToPersistence() {
        do {
            let data = try JSONEncoder().encode(favoriteMovies)
            try data.write(to: createFileForPersistence())
        } catch {
            print(error)
            print(error.localizedDescription)
        }
    }
    
    // LOAD
    func loadFromPersistance() {
        do {
            let data = try Data(contentsOf: createFileForPersistence())
            favoriteMovies = try JSONDecoder().decode([FavoriteMovie].self, from: data)
        } catch {
            print(error)
            print(error.localizedDescription)
        }
    }
}
