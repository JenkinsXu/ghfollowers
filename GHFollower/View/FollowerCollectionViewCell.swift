//
//  GFFollowerCollectionViewCell.swift
//  GHFollower
//
//  Created by Yongqi Xu on 2020-09-08.
//  Copyright © 2020 Yongqi Xu. All rights reserved.
//

import UIKit

class FollowerCollectionViewCell: UICollectionViewCell {
    static let reuseID = "FollowerCell"
    var follower: Follower? {
        didSet {
            usernameLabel.text = follower!.login
            avatarImageView.updateImage(from: follower!.avatarUrl)
        }
    }
    
    let avatarImageView = GFImageView(frame: .zero)
    let usernameLabel = GFTitleLabel("Loading", alignTo: .center)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        contentView.addSubview(avatarImageView)
        contentView.addSubview(usernameLabel)
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            avatarImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            usernameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 4),
            usernameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            usernameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8)
        ])
    }
}
