//
//  FavoriteTableViewCell.swift
//  GHFollower
//
//  Created by Yongqi Xu on 2020-09-22.
//  Copyright © 2020 Yongqi Xu. All rights reserved.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {

    static let reuseID = "FavoriteCell"
    var follower: Follower? {
        didSet {
            usernameLabel.text = follower!.login
            avatarImageView.updateImage(from: follower!.avatarUrl)
        }
    }
    
    let avatarImageView = GFImageView(frame: .zero)
    let usernameLabel = GFTitleLabel("Loading", alignTo: .center)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        contentView.addSubview(avatarImageView)
        contentView.addSubview(usernameLabel)
        accessoryType = .disclosureIndicator
        
        NSLayoutConstraint.activate([
            avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            avatarImageView.widthAnchor.constraint(equalToConstant: 70),
            avatarImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            usernameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 12),
            usernameLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor),
        ])
    }

}
