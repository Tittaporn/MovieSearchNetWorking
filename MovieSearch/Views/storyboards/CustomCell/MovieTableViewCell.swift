//
//  MovieTableViewCell.swift
//  MovieSearch
//
//  Created by Lee McCormick on 1/29/21.
//

import UIKit

// MARK: - Protocol
protocol MovieTableCellDelegate: AnyObject {
    func favoriteMovieButtonTapped(sender: MovieTableViewCell, isFavorite: Bool)
}

class MovieTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieRatingLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    // MARK: - Properties
    var movie: Movie? {
        didSet {
            updateViewCellWith(movie: movie!)
        }
    }
    var isThisMovieFavorite: Bool = false
    weak var delegate: MovieTableCellDelegate?
    
    // MARK: - Actions
    @IBAction func favoriteBottonTapped(_ sender: Any) {
        isThisMovieFavorite.toggle()
        delegate?.favoriteMovieButtonTapped(sender: self, isFavorite: isThisMovieFavorite)
    }
    
    // MARK: - Helper Fuctions
    func   updateViewCellWith(movie: Movie) {
        movieTitleLabel.text = " \(movie.title)"
        movieRatingLabel.text = " Rating : \(movie.rating)"
        let starFavoriteImage = isThisMovieFavorite ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
        favoriteButton.setImage(starFavoriteImage, for: .normal)
    }
}
