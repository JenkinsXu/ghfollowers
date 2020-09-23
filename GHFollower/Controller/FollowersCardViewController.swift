//
//  FollowersCardViewController.swift
//  GHFollower
//
//  Created by Yongqi Xu on 2020-09-21.
//  Copyright © 2020 Yongqi Xu. All rights reserved.
//

import UIKit

protocol FollowersCardViewControllerDelegate: class {
    func didTapGetFollowersButton()
}

class FollowersCardViewController: CardViewController {

    var user: User!
    weak var delegate: FollowersCardViewControllerDelegate!
    
    init(user: User) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
    }
    
    func configure() {
        actionButton.setTitle("Get Followers", for: .normal)
        
        leadingDataView.update(iconImage: SFSymbols.following, title: "Following", value: user.following)
        trailingDataView.update(iconImage: SFSymbols.followers, title: "Followers", value: user.followers)
    }
    
    @objc override func buttonTapped() {
        guard user.followers != 0 else {
            presentAlert(title: "Cannot complete request", description: "This user has no followers, try another one.", buttonText: "OK")
            return
        }
        delegate.didTapGetFollowersButton()
    }

}
