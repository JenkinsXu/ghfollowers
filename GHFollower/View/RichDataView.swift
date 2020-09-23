//
//  RichDataView.swift
//  GHFollower
//
//  Created by Yongqi Xu on 2020-09-20.
//  Copyright © 2020 Yongqi Xu. All rights reserved.
//

import UIKit

class RichDataView: UIView {
    
    var iconImageView = UIImageView(image: SFSymbols.publicGists)
    let titleLabel = GFBodyLabel("Loading", alignTo: .natural)
    let valueLabel = GFBodyLabel("0", alignTo: .center)
    
    init() {
        super.init(frame: .zero)
        configure()
    }
    
    init(iconImage: UIImage, title: String, value: Int) {
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(iconImageView)
        iconImageView.tintColor = .label
        NSLayoutConstraint.activate([
            iconImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            iconImageView.topAnchor.constraint(equalTo: topAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 18),
            iconImageView.heightAnchor.constraint(equalTo: iconImageView.widthAnchor),
        ])
        
        addSubview(titleLabel)
        titleLabel.textColor = .label
        
        // Must set the trailing here
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 8),
            titleLabel.centerYAnchor.constraint(equalTo: iconImageView.centerYAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
        
        addSubview(valueLabel)
        valueLabel.textColor = .label
        NSLayoutConstraint.activate([
            valueLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            valueLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            valueLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            valueLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    func update(iconImage: UIImage, title: String, value: Int) {
        iconImageView.image = iconImage
        titleLabel.text = title
        valueLabel.text = String(value)
    }

}
