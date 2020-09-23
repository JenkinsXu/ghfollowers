//
//  UIViewControllerExtension.swift
//  GHFollower
//
//  Created by Yongqi Xu on 2020-09-07.
//  Copyright © 2020 Yongqi Xu. All rights reserved.
//

import UIKit

extension UIView {
    func pin(to view: UIView, topPadding: CGFloat = 0, bottomPadding: CGFloat = 0, leadingPadding: CGFloat = 0, trailingPadding: CGFloat = 0) {
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: view.topAnchor, constant: topPadding),
            self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: bottomPadding),
            self.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leadingPadding),
            self.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: trailingPadding)
        ])
    }
    
    func pin(to view: UIView, padding: CGFloat = 0) {
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: padding),
            self.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            self.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: padding)
        ])
    }
    
    func pinToTop(of view: UIView, topPadding: CGFloat = 0, leadingPadding: CGFloat = 0, trailingPadding: CGFloat = 0, height: CGFloat) {
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: height),
            self.topAnchor.constraint(equalTo: view.topAnchor, constant: topPadding),
            self.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leadingPadding),
            self.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: trailingPadding)
        ])
    }
    
    func pinToBottom(of view: UIView, bottomPadding: CGFloat = 0, leadingPadding: CGFloat = 0, trailingPadding: CGFloat = 0, height: CGFloat) {
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: height),
            self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: bottomPadding),
            self.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leadingPadding),
            self.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: trailingPadding)
        ])
    }
    
    func addSubviews(_ subviews: UIView...) {
        for subview in subviews {
            addSubview(subview)
        }
    }
}
