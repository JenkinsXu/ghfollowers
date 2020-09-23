//
//  UserHeaderView.swift
//  GHFollower
//
//  Created by Yongqi Xu on 2020-09-20.
//  Copyright © 2020 Yongqi Xu. All rights reserved.
//

import UIKit

class UserHeaderView: UIView {
    
    var user: User!

    let avatarImageView = GFImageView(frame: .zero)
    let nameLabel = GFLargeUsernameLabel("Loading", alignTo: .natural)
    let realnameLabel = GFBodyLabel("", alignTo: .natural)
    let locationContainerView = UIView()
    let locationIconImageView = UIImageView()
    let locationLabel = GFBodyLabel("", alignTo: .natural)
    let bioLabel = GFBodyLabel("", alignTo: .natural)
    
    init(user: User) {
        super.init(frame: .zero)
        self.user = user
        configureConstraints()
        updateData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureConstraints() {
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(avatarImageView)
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: topAnchor),
            avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            avatarImageView.widthAnchor.constraint(equalToConstant: 100),
        ])
        
        locationIconImageView.image = SFSymbols.location
        locationIconImageView.tintColor = .systemGreen
        locationIconImageView.translatesAutoresizingMaskIntoConstraints = false
        locationContainerView.translatesAutoresizingMaskIntoConstraints = false
        locationContainerView.addSubviews(locationIconImageView, locationLabel)
        addSubview(locationContainerView)
        NSLayoutConstraint.activate([
            locationIconImageView.topAnchor.constraint(equalTo: locationContainerView.topAnchor),
            locationIconImageView.leadingAnchor.constraint(equalTo: locationContainerView.leadingAnchor),
            locationLabel.leadingAnchor.constraint(equalTo: locationIconImageView.trailingAnchor, constant: 5),
            locationLabel.centerYAnchor.constraint(equalTo: locationIconImageView.centerYAnchor),
        ])
        
        let textLabelsStackView = UIStackView(arrangedSubviews: [nameLabel, realnameLabel, locationContainerView])
        textLabelsStackView.axis = .vertical
        textLabelsStackView.spacing = 8
        textLabelsStackView.alignment = .leading
        textLabelsStackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(textLabelsStackView)
        NSLayoutConstraint.activate([
            textLabelsStackView.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 18),
            textLabelsStackView.topAnchor.constraint(equalTo: topAnchor),
        ])
        
        
        bioLabel.translatesAutoresizingMaskIntoConstraints = false
        bioLabel.numberOfLines = 4
        addSubview(bioLabel)
        NSLayoutConstraint.activate([
            bioLabel.topAnchor.constraint(equalTo: textLabelsStackView.bottomAnchor, constant: 36),
            bioLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            bioLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            bioLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func updateData() {
        avatarImageView.updateImage(from: user.avatarUrl)
        nameLabel.text = user.login
        realnameLabel.text = user.name ?? "Real name not available"
        locationLabel.text = user.location ?? "Earth"
        bioLabel.text = user.bio ?? "Bio not available"
    }
    
}
