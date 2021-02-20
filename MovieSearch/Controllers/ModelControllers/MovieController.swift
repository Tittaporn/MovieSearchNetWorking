//
//  MovieController.swift
//  MovieSearch
//
//  Created by Lee McCormick on 1/29/21.
//

import UIKit

class MovieController {
    
    // MARK: - URL Properties
    static let baseURL = URL(string: "https://api.themoviedb.org")
    static let threeComponent = "3"
    static let searchComponent = "search"
    static let movieComponent = "movie"
    static let apiKey = "api_key"
    static let apiKeyValue = "dce1a7c0d50cbf9104f074bd367277a8"
    static let searchMovieKey = "query"
    static let imageBaseURL = URL(string: "https://image.tmdb.org/t/p/w500")
    
    // MARK: - Fetch Movies
    static func fetchMovies(movieNameSearchTerm: String, completion: @escaping (Result<[Movie],MovieError>) -> Void) {
        
        guard let baseURL = baseURL else { return completion(.failure(.invalidURL))}
        let threeURL = baseURL.appendingPathComponent(threeComponent)
        let serachURL = threeURL.appendingPathComponent(searchComponent)
        let movieURL = serachURL.appendingPathComponent(movieComponent)
        
        var components = URLComponents(url: movieURL, resolvingAgainstBaseURL: true)
        let apiQuery = URLQueryItem(name: apiKey, value: apiKeyValue)
        let searchMovieQuery = URLQueryItem(name: searchMovieKey, value: movieNameSearchTerm)
        components?.queryItems = [apiQuery, searchMovieQuery]
        
        guard let finalURL = components?.url else { return completion(.failure(.invalidURL))}
        print("\nFinalURL for FetchMovie ::: \(finalURL)")
        // https://api.themoviedb.org/3/search/movie?api_key=dce1a7c0d50cbf9104f074bd367277a8&query=Jack+Reacher
        
        URLSession.shared.dataTask(with: finalURL) { (data, response, error) in
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            
            if let response = response as? HTTPURLResponse {
                print("FETCH MOVIE STATUS CODE : \(response.statusCode)")
            }
            
            guard let data = data else { return completion(.failure(.noData))}
            do {
                let topLevelObject = try JSONDecoder().decode(TopLevelObject.self, from: data)
                let movies = topLevelObject.results
                return completion(.success(movies))
            } catch {
                return completion(.failure(.thrownError(error)))
            }
        }.resume()
    }
    
    // MARK: - Fetch Poster
    static func fetchPoster(with posterURLPath: String, completion: @escaping (Result<UIImage,MovieError>) -> Void) {
        
        guard let imageBaseURL = imageBaseURL else {return completion(.failure(.invalidURL))}
        let posterURL = imageBaseURL.appendingPathComponent(posterURLPath)
        print("\nPosterURL ::: \(posterURL)")
        // https://image.tmdb.org/t/p/w500/9vaRPXj44Q2meHgt3VVfQufiHOJ.jpg
        
        URLSession.shared.dataTask(with: posterURL) { (data, response, error) in
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            
            if let response = response as? HTTPURLResponse {
                print("FETCH POSTER STATUS CODE : \(response.statusCode)")
            }
            
            guard let data = data else { return completion(.failure(.noData))}
            guard let poster = UIImage(data: data) else {return completion(.failure(.unableToDecode))}
            completion(.success(poster))
        }.resume()
    }
}
