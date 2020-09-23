//
//  UserViewController.swift
//  GHFollower
//
//  Created by Yongqi Xu on 2020-09-20.
//  Copyright © 2020 Yongqi Xu. All rights reserved.
//

import UIKit

protocol UserViewControllerDelegate: class {
    func updateDataFromUser(username: String)
}

class UserViewController: UIViewController {
    
    var user: User!
    weak var delegate: UserViewControllerDelegate!
    
    var headerView: UserHeaderView!
    var dateLabel = GFBodyLabel("Loading", alignTo: .center)
    var profileCard: ProfileCardViewController!
    var followersCard: FollowersCardViewController!

    init(user: User) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBackground()
        configureNavigationBar()
        configureHeaderView()
        configureCards()
        configureDateLabel()
    }
    
    func configureBackground() {
        view.backgroundColor = .systemBackground
    }
    
    func configureNavigationBar() {
        navigationItem.rightBarButtonItem = .init(barButtonSystemItem: .done, target: self, action: #selector(dismissViewController))
    }
    
    @objc func dismissViewController() {
        dismiss(animated: true, completion: nil)
    }
    
    func configureHeaderView() {
        headerView = UserHeaderView(user: user)
        view.addSubview(headerView)
        
        NSLayoutConstraint.activate([
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18),
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 18),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -18)
        ])
    }
    
    func configureCards() {
        profileCard = ProfileCardViewController(user: user)
        addChild(profileCard)
        view.addSubview(profileCard.view)
        profileCard.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            profileCard.view.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 18),
            profileCard.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18),
            profileCard.view.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -18),
        ])
        profileCard.didMove(toParent: self)
        profileCard.delegate = self
        
        followersCard = FollowersCardViewController(user: user)
        addChild(followersCard)
        view.addSubview(followersCard.view)
        followersCard.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            followersCard.view.topAnchor.constraint(equalTo: profileCard.view.bottomAnchor, constant: 18),
            followersCard.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18),
            followersCard.view.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -18),
        ])
        followersCard.didMove(toParent: self)
        followersCard.delegate = self
    }
    
    func configureDateLabel() {
        let formatter = DateFormatter()
        formatter.locale = .current
        formatter.dateFormat = "MMMM YYYY"
        dateLabel.text = "GitHub since \(formatter.string(from: user.createdAt))"
        dateLabel.font = .italicSystemFont(ofSize: 12)
        dateLabel.textColor = .tertiaryLabel
        
        view.addSubview(dateLabel)
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: followersCard.view.bottomAnchor, constant: 8),
            dateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18),
            dateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -18),
        ])
    }

}

extension UserViewController: ProfileCardViewControllerDelegate, FollowersCardViewControllerDelegate {
    func didTapGetFollowersButton() {
        delegate.updateDataFromUser(username: user.login)
        dismiss(animated: true, completion: nil)
    }
    
    func didTapProfileButton() {
        presentSafariViewController(urlString: user.htmlUrl)
    }

}
