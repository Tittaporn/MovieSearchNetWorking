//
//  MovieViewController.swift
//  MovieSearch
//
//  Created by Lee McCormick on 1/29/21.
//

import UIKit

class MovieViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var ratingLebel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var movieSummaryTextView: UITextView!
    
    // MARK: - Properties
    var movie: Movie?
    
    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    // MARK: - Helper Fuctions
    func updateViews() {
        guard let movie = movie else { return }
        movieTitleLabel.text = movie.title
        ratingLebel.text = "Rating : \(movie.rating)"
        movieSummaryTextView.text = movie.summary
        movieSummaryTextView.isEditable = false
        fetchPosterImage(movie: movie)
    }
    
    func fetchPosterImage(movie: Movie) {
        MovieController.fetchPoster(with: movie.poster) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let posterImage):
                    self.posterImageView.image = posterImage
                case .failure(let error):
                    self.presentErrorToUser(localizedError: error)
                }
            }
        }
    }
}
