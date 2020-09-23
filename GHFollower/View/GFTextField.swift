//
//  GFTextField.swift
//  GHFollower
//
//  Created by Yongqi Xu on 2020-09-07.
//  Copyright © 2020 Yongqi Xu. All rights reserved.
//

import UIKit

class GFTextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        
        #if DEBUG
        text = "SAllen0400"
        #endif
        
        translatesAutoresizingMaskIntoConstraints = false
        
        // Border
        layer.cornerRadius = 10
        layer.cornerCurve = .continuous
        layer.borderColor = UIColor.systemGray.cgColor
        layer.borderWidth = 0.5
        
        // Color
        textColor = .label
        tintColor = .systemGreen
        backgroundColor = .tertiarySystemBackground
        
        // Text
        font = .preferredFont(forTextStyle: .title2)
        textAlignment = .center
        adjustsFontSizeToFitWidth = true
        minimumFontSize = 12
        autocorrectionType = .no
        placeholder = "Enter a username"
        
        // Keyboard
        returnKeyType = .go
        clearButtonMode = .whileEditing
    }
}
