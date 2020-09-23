//
//  GFButton.swift
//  GHFollower
//
//  Created by Yongqi Xu on 2020-09-07.
//  Copyright © 2020 Yongqi Xu. All rights reserved.
//

import UIKit

class GFButton: UIButton {
    override var isHighlighted: Bool {
        didSet {
            UIView.animate(withDuration: 0.1) {
                self.alpha = self.isHighlighted ? 0.6 : 1
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    init(buttonText: String) {
        super.init(frame: .zero)
        setTitle(buttonText, for: .normal)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        
        // Color
        backgroundColor = .systemGreen
        setTitleColor(.white, for: .normal)
        
        // Shape
        layer.cornerRadius = 10
        layer.cornerCurve = .continuous
        
        // Text
        titleLabel?.font = .preferredFont(forTextStyle: .headline)
        titleLabel?.textAlignment = .center
        
        // Constraint
        heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
}
