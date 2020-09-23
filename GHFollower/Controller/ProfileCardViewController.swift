//
//  ProfileCardViewController.swift
//  GHFollower
//
//  Created by Yongqi Xu on 2020-09-21.
//  Copyright © 2020 Yongqi Xu. All rights reserved.
//

import UIKit

protocol ProfileCardViewControllerDelegate: class {
    func didTapProfileButton()
}

class ProfileCardViewController: CardViewController {

    var user: User!
    weak var delegate: ProfileCardViewControllerDelegate!
    
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
        actionButton.setTitle("Github Profile", for: .normal)
        actionButton.backgroundColor = .systemPurple
        
        
        leadingDataView.update(iconImage: SFSymbols.publicRepos, title: "Public Repos", value: user.publicRepos)
        trailingDataView.update(iconImage: SFSymbols.publicGists, title: "Public Gists", value: user.publicGists)
    }
    
    @objc override func buttonTapped() {
        delegate.didTapProfileButton()
    }

}
