//
//  LoadingExtension.swift
//  GHFollower
//
//  Created by Yongqi Xu on 2020-09-10.
//  Copyright © 2020 Yongqi Xu. All rights reserved.
//

import UIKit
import SafariServices

fileprivate var indicatorBackgroundView: UIView!

extension UIViewController {
    func showIndicator() {

        indicatorBackgroundView = UIView(frame: view.bounds)
        view.addSubview(indicatorBackgroundView)
        indicatorBackgroundView.backgroundColor = .systemBackground
        indicatorBackgroundView.alpha = 0
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .systemGray
        indicatorBackgroundView.addSubview(activityIndicator)

        indicatorBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        indicatorBackgroundView.pin(to: view)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: indicatorBackgroundView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: indicatorBackgroundView.centerYAnchor),
        ])

        activityIndicator.startAnimating()
        UIView.animate(withDuration: 0.4) {
            indicatorBackgroundView.alpha = 0.6
        }
    }
    
    func hideIndicator() {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.4) {
                indicatorBackgroundView.alpha = 0
            }
            indicatorBackgroundView.removeFromSuperview()
            indicatorBackgroundView = nil
        }
    }
    
    func showEmptyStateView(with description: String) {
        DispatchQueue.main.async {
            let emptyStateView = GFEmptyStateView(description: description)
            self.view.addSubview(emptyStateView)
            emptyStateView.pin(to: self.view)
        }
    }
    
    func presentSafariViewController(urlString: String) {
        guard let url = URL(string: urlString) else {
            presentAlert(title: "Invalid URL", description: "The url attached to this user is invalid.", buttonText: "OK")
            return
        }
        let safariViewController = SFSafariViewController(url: url)
        safariViewController.preferredControlTintColor = .systemGreen
        present(safariViewController, animated: true, completion: nil)
    }
    
}
