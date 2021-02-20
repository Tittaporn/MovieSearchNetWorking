//
//  MovieTableViewCell.swift
//  MovieSearch
//
//  Created by Lee McCormick on 1/29/21.
//

import UIKit

// MARK: - Protocol
protocol MovieTableCellDelegate: AnyObject {
    func favoriteMovieButtonTapped(movie: Movie, isFavorite: Bool )
}

class MovieTableViewCell: UITableViewCell {
    
    
    // MARK: - Outlets
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieRatingLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    // MARK: - Properties
    var movie: Movie? {
        didSet {
            updateViewCell()
        }
    }
    var favoriteMovies: [Movie] = []
    var isFavorite: Bool = false
    weak var delegate: MovieTableCellDelegate?
    
    // MARK: - Actions
    @IBAction func favoriteBottonTapped(_ sender: Any) {
        guard let movie = movie else { return }
        isFavorite.toggle()
        if isFavorite {
            favoriteMovies.append(movie)
        }
        delegate?.favoriteMovieButtonTapped(movie: movie, isFavorite: isFavorite)
    }
    
    // MARK: - Helper Fuctions
    func updateViewCell() {
        guard let movie = movie else { return }
        movieTitleLabel.text = " \(movie.title)"
        movieRatingLabel.text = " Rating : \(movie.rating)"
        
        let starFavoriteImage = isFavorite ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
        favoriteButton.setImage(starFavoriteImage, for: .normal)
    }
}
