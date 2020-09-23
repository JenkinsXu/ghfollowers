//
//  GFEmptyStateView.swift
//  GHFollower
//
//  Created by Yongqi Xu on 2020-09-10.
//  Copyright © 2020 Yongqi Xu. All rights reserved.
//

import UIKit

class GFEmptyStateView: UIView {

    var descriptionLabel = GFTitleLabel("", alignTo: .center)
    let backgroundImage = UIImageView(image: UIImage(named: "empty-state-logo"))

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(description: String) {
        super.init(frame: .zero)
        descriptionLabel.text = description
        configure()
    }
    
    func configure() {
        addSubview(backgroundImage)
        addSubview(descriptionLabel)
        
        descriptionLabel.numberOfLines = 0
        descriptionLabel.font = .preferredFont(forTextStyle: .headline)
        descriptionLabel.textColor = .secondaryLabel
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            descriptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            descriptionLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -120),
            
            backgroundImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 160),
            backgroundImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 50),
            backgroundImage.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
            backgroundImage.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3)
        ])
    }
    
}
