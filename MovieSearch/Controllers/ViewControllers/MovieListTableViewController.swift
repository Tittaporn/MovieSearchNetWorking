//
//  MovieListTableViewController.swift
//  MovieSearch
//
//  Created by Lee McCormick on 1/29/21.
//

import UIKit

class MovieListTableViewController: UITableViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var movieSearchBar: UISearchBar!
    
    // MARK: - Properties
    var movies: [Movie] = []
    var favoriteMovies: [Movie] = []
    
    
    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        movieSearchBar.delegate = self
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as? MovieTableViewCell else { return UITableViewCell() }
        let movie = movies[indexPath.row]
        cell.movie = movie
        cell.delegate = self
        return cell
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toMovieVC" {
            guard let indexPath = tableView.indexPathForSelectedRow,
                  let destinationVC = segue.destination as? MovieViewController else { return }
            let movie = movies[indexPath.row]
            destinationVC.movie = movie
        }
    }
}
//        } else if segue.identifier == "toFavoriteListVC" {
//            guard let destinationFavoriteVC = segue.destination as? FavoriteMovieListTableViewController else { return }
//            let favoriteMovies = self.favoriteMovies
//            destinationFavoriteVC.favoriteMovies = favoriteMovies
//        }
//    }
//}

// MARK: - Extension UISearchBarDelegate
extension MovieListTableViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let movieSearchTerm = searchBar.text else { return }
        MovieController.fetchMovies(movieNameSearchTerm: movieSearchTerm) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let movies):
                    self.movies = movies
                    self.tableView.reloadData()
                case .failure(let error):
                    self.presentErrorToUser(localizedError: error)
                }
            }
        }
    }
}

// MARK: - Extension MovieTableCellDelegate
extension MovieListTableViewController: MovieTableCellDelegate {
    func favoriteMovieButtonTapped(movie: Movie, isFavorite: Bool) {
        var isFavoriteMovie = isFavorite
        if isFavoriteMovie {
            self.favoriteMovies.append(movie)
        }
        isFavoriteMovie.toggle()
        print(favoriteMovies.count)
        tableView.reloadData()
    }
}

