//
//  FollowersViewController.swift
//  GHFollower
//
//  Created by Yongqi Xu on 2020-09-07.
//  Copyright © 2020 Yongqi Xu. All rights reserved.
//

import UIKit

class FollowersViewController: UIViewController {
    var username: String! {
        didSet {
            title = username
        }
    }
    var collectionView: UICollectionView!
    var currentPage = 1
    var hasMoreFollowers = true
    var filteredFollowers: [Follower] = []
    var followers: [Follower] = [] {
        didSet {
            updateData(on: followers)
        }
    }
    
    enum Section {
        case main
    }
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configure()
        configureSearchBar()
        configureDataSource()
        configureAddButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func configure() {
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .systemBackground
        
        fetchFollowers(withName: username, onPage: currentPage)
    }
    
    func configureSearchBar() {
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate   = self
        searchController.searchBar.placeholder = "Search follower"
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = true
    }
    
    func fetchFollowers(withName username: String, onPage page: Int) {
        showIndicator()
        NetworkManager.shared.getFollowers(username: username, page: page) { [weak self] result in
            guard let self = self else {return}
            self.hideIndicator()
            switch result {
            case .failure(let error):
                self.presentAlert(title: "Unable to complete request", description: error.rawValue, buttonText: "OK")
            case .success(let newFollowers):
                if newFollowers.isEmpty {
                    self.showEmptyStateView(with: "This person has no follower.")
                    return
                }
                if newFollowers.count < 100 { self.hasMoreFollowers = false }
                self.followers.append(contentsOf: newFollowers)
            }
        }
    }
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createThreeColumnLayout())
        view.addSubview(collectionView)
        collectionView.register(FollowerCollectionViewCell.self, forCellWithReuseIdentifier: FollowerCollectionViewCell.reuseID)
        collectionView.backgroundColor = .systemBackground
        
        collectionView.delegate = self
    }
    
    func createThreeColumnLayout() -> UICollectionViewFlowLayout {
        let padding: CGFloat = 12
        let interItemSpacing: CGFloat = 10
        let screenWidth = view.bounds.width
        let availableScreenWidth = screenWidth - (2 * padding) - (2 * interItemSpacing)
        let itemWidth = availableScreenWidth / 3
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 40)
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        
        return flowLayout
    }
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, follower) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCollectionViewCell.reuseID, for: indexPath) as! FollowerCollectionViewCell
            cell.follower = follower
            return cell
        })
        
    }
    
    func updateData(on followers: [Follower]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true, completion: nil)
        }
    }
    
}

extension FollowersViewController: UICollectionViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        guard hasMoreFollowers else { return }
        
        let offset = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let screenHeight = scrollView.frame.size.height
        let hasReachedBottom = offset >= contentHeight - 2 * screenHeight
        
        if hasReachedBottom {
            currentPage += 1
            fetchFollowers(withName: username, onPage: currentPage)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let isSearchBarActive = navigationItem.searchController?.isActive else { return }
        let selectedFollower = (isSearchBarActive ? filteredFollowers : followers)[indexPath.item]
        NetworkManager.shared.getUser(username: selectedFollower.login) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                    let userViewController = UserViewController(user: user)
                    userViewController.delegate = self
                    self.present(UINavigationController(rootViewController: userViewController), animated: true, completion: nil)
                }
            case .failure(let errorMessage):
                self.presentAlert(title: "Network Error", description: errorMessage.rawValue, buttonText: "OK")
            }
        }
        
    }
    
    func configureAddButton() {
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        addButton.tintColor = .systemGreen
        navigationItem.rightBarButtonItem = addButton
    }
    
    @objc func addButtonTapped() {
        NetworkManager.shared.getUser(username: username) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let user):
                let follower = Follower(login: user.login, avatarUrl: user.avatarUrl)
                guard let error = PersistenceManager.update(favorite: follower, actionType: .add) else {
                    self.presentAlert(title: "⭐️ Added To Favorite", description: "This user has been successfully added to favorites.", buttonText: "Done")
                    self.disableAddButton()
                    return
                }
                self.presentAlert(title: "🥵 Action Not Completed", description: error.rawValue, buttonText: "OK", buttonColor: .systemPurple)
                self.disableAddButton()
            case .failure(let errorMessage):
                self.presentAlert(title: "Network Error", description: errorMessage.rawValue, buttonText: "OK")
            }
        }
        
    }
    
    func disableAddButton() {
        DispatchQueue.main.async {
            self.navigationItem.rightBarButtonItem?.isEnabled = false
        }
    }
    
    func enableAddButton() {
        DispatchQueue.main.async {
            self.navigationItem.rightBarButtonItem?.isEnabled = true
        }
    }
    
}

extension FollowersViewController: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else { return }
        filteredFollowers = followers.filter{ $0.login.lowercased().contains(filter.lowercased()) }
        updateData(on: filteredFollowers)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        updateData(on: followers)
    }
}

extension FollowersViewController: UserViewControllerDelegate {
    func updateDataFromUser(username: String) {
        self.username = username
        title = username
        currentPage = 1
        followers.removeAll()
        filteredFollowers.removeAll()
        self.hasMoreFollowers = true
        fetchFollowers(withName: self.username, onPage: currentPage)
        updateData(on: followers)
        print("The Button is being reset.")
        enableAddButton()
    }
    
}
