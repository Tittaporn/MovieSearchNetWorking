//
//  FavoriteMovieListTableViewController.swift
//  MovieSearch
//
//  Created by Lee McCormick on 1/29/21.
//

import UIKit

class FavoriteMovieListTableViewController: UITableViewController {
    
    // MARK: - Properties
    var favoriteMovies: [Movie] = []
    
    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        FavoriteMovieController.shared.loadFromPersistance()
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FavoriteMovieController.shared.favoriteMovies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteMovieCell", for: indexPath)
        let favoriteMovie = FavoriteMovieController.shared.favoriteMovies[indexPath.row]
        cell.textLabel?.text = favoriteMovie.title
        cell.textLabel?.font =  UIFont(name: "Apple Color Emoji", size: 18)!
        cell.detailTextLabel?.text = "Rating: \(favoriteMovie.rating)"
        cell.detailTextLabel?.font =  UIFont(name: "Apple Color Emoji", size: 14)!
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let favoriteToDelete = FavoriteMovieController.shared.favoriteMovies[indexPath.row]
            FavoriteMovieController.shared.deleteFavoriteMovieWith(favoriteMovie: favoriteToDelete)
                    tableView.reloadData()
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toMovieVC" {
            guard let indexPath = tableView.indexPathForSelectedRow,
                  let destinationVC = segue.destination as? MovieViewController else { return }
            let favoriteMovie = FavoriteMovieController.shared.favoriteMovies[indexPath.row]
            destinationVC.favoriteMovie = favoriteMovie
        }
    }
}
