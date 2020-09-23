//
//  GFAlertViewController.swift
//  GHFollower
//
//  Created by Yongqi Xu on 2020-09-07.
//  Copyright © 2020 Yongqi Xu. All rights reserved.
//

import UIKit

class GFAlertViewController: UIViewController {

    var alertTitle: String?
    var alertDescription: String?
    var buttonText: String?
    var buttonColor: UIColor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    init(alertTitle: String, alertDescription: String, buttonText: String, buttonColor: UIColor = .systemGreen) {
        super.init(nibName: nil, bundle: nil)
        self.alertTitle = alertTitle
        self.alertDescription = alertDescription
        self.buttonText = buttonText
        self.buttonColor = buttonColor
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        // Dim content behind, cannot be done with layer
        view.backgroundColor = UIColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 0.3)
        
        // Content
        let titleLabel = GFTitleLabel(alertTitle!, alignTo: .center)
        let descriptionLabel = GFBodyLabel(alertDescription!, alignTo: .center)
        let button = GFButton(buttonText: buttonText!)
        
        let contentView = UIStackView(arrangedSubviews: [
            titleLabel,
            descriptionLabel,
            button
        ])
        view.addSubview(contentView)
        
        // Blur background
        let dummyView = UIView(frame: contentView.bounds)
        contentView.insertSubview(dummyView, at: 0)
        dummyView.pin(to: contentView)
        let blurEffect = UIBlurEffect(style: .systemMaterial)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = dummyView.bounds
        blurEffectView.layer.cornerRadius = 10
        blurEffectView.layer.cornerCurve = .continuous
        blurEffectView.layer.masksToBounds = true
        blurEffectView.layer.borderColor = UIColor.systemGray.cgColor
        blurEffectView.layer.borderWidth = 0.5
        dummyView.addSubview(blurEffectView)
        blurEffectView.pin(to: dummyView)
        
        dummyView.layer.shadowColor = UIColor.black.cgColor
        dummyView.layer.shadowOffset = CGSize(width: 0, height: 10.0)
        dummyView.layer.shadowOpacity = 0.25
        dummyView.layer.shadowRadius = 18.0
        
        // Content view
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.spacing = 20
        contentView.axis = .vertical
        contentView.alignment = .center
        contentView.isLayoutMarginsRelativeArrangement = true
        contentView.directionalLayoutMargins = NSDirectionalEdgeInsets(
            top: 20,
            leading: 20,
            bottom: 20,
            trailing: 20
        )
        
        
        
        NSLayoutConstraint.activate([
            contentView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            contentView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            contentView.widthAnchor.constraint(equalToConstant: 300),
            button.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.85),
        ])
        
        // TODO: Refactor this part
        button.addTarget(self, action: #selector(dismissAlert), for: .touchUpInside)
        button.backgroundColor = buttonColor
    }
    
    @objc func dismissAlert() {
        dismiss(animated: true, completion: nil)
    }
    
}

extension UIViewController {
    func presentAlert(title: String, description: String, buttonText: String, buttonColor: UIColor = .systemGreen) {
        // Showing 2 different view controllers at the same time
        DispatchQueue.main.async {
            let alert = GFAlertViewController(
                alertTitle: title,
                alertDescription: description,
                buttonText: buttonText,
                buttonColor: buttonColor
            )
            alert.modalPresentationStyle = .overFullScreen
            alert.modalTransitionStyle = .crossDissolve
            self.present(alert, animated: true, completion: nil)
        }
    }
}
