//
//  FavouriteViewController.swift
//  GHFollower
//
//  Created by Yongqi Xu on 2020-09-07.
//  Copyright © 2020 Yongqi Xu. All rights reserved.
//

import UIKit

class FavouriteViewController: UITableViewController {
    
    var favorites: [Follower] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        fetchAllFavorites()
        configureDataSourceAndDelegate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchAllFavorites()
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func fetchAllFavorites() {
        PersistenceManager.retrive { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let favorites):
                self.favorites = favorites
            case .failure(let errorMessage):
                self.presentAlert(title: "Unable to load favorites", description: errorMessage.rawValue, buttonText: "OK")
            }
        }
        tableView.reloadData()
    }
    
    func configureDataSourceAndDelegate() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(FavoriteTableViewCell.self, forCellReuseIdentifier: FavoriteTableViewCell.reuseID)
        tableView.rowHeight = 80
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let favorite = favorites[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteTableViewCell.reuseID) as! FavoriteTableViewCell
        cell.follower = favorite
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        let favorite = favorites[indexPath.row]
        favorites.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
        
        guard let error = PersistenceManager.update(favorite: favorite, actionType: .remove) else { return }
        presentAlert(title: "Unable to delete", description: error.rawValue, buttonText: "OK")
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favorite = favorites[indexPath.row]
        
        let followersViewController = FollowersViewController()
        followersViewController.username = favorite.login
        navigationController?.pushViewController(followersViewController, animated: true)
    }
}
