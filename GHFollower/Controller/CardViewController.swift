//
//  CardViewController.swift
//  GHFollower
//
//  Created by Yongqi Xu on 2020-09-20.
//  Copyright © 2020 Yongqi Xu. All rights reserved.
//

import UIKit

class CardViewController: UIViewController {
    
    let leadingDataView = RichDataView()
    let trailingDataView = RichDataView()
    let actionButton = GFButton(buttonText: "Loading")

    override func viewDidLoad() {
        super.viewDidLoad()
        configureBackground()
        addConstraints()
        actionButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    func configureBackground() {
        view.backgroundColor = .secondarySystemBackground
        view.layer.cornerRadius = 18
        view.layer.cornerCurve = .continuous
    }
    
    func addConstraints() {
        let dataStackView = UIStackView(arrangedSubviews: [leadingDataView, trailingDataView])
        dataStackView.axis = .horizontal
        dataStackView.alignment = .center
        dataStackView.distribution = .equalSpacing
        dataStackView.translatesAutoresizingMaskIntoConstraints = false
        dataStackView.isLayoutMarginsRelativeArrangement = true
        dataStackView.layoutMargins = UIEdgeInsets(top: 18, left: 18, bottom: 0, right: 18)
        
        view.addSubview(dataStackView)
        view.addSubview(actionButton)
        NSLayoutConstraint.activate([
            dataStackView.topAnchor.constraint(equalTo: view.topAnchor),
            dataStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dataStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18),
            actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -18),
            actionButton.topAnchor.constraint(equalTo: dataStackView.bottomAnchor, constant: 9),
            actionButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -18),
        ])

    }
    
    @objc func buttonTapped() {}

}
