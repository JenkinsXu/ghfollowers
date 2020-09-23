//
//  SearchViewController.swift
//  GHFollower
//
//  Created by Yongqi Xu on 2020-09-07.
//  Copyright © 2020 Yongqi Xu. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    let logoImageView = UIImageView(image: UIImage(named: "gh-logo"))
    let usernameTextField = GFTextField()
    let getFollowersButtom = GFButton(buttonText: "Get Followers")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Background
        view.backgroundColor = .systemBackground
        
        configureImageView()
        configureTextField()
        configureButton()
        configureKeyboardDismiss()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func configureImageView() {
        view.addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            logoImageView.widthAnchor.constraint(equalToConstant: 200),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    func configureTextField() {
        view.addSubview(usernameTextField)
        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        usernameTextField.delegate = self
        
        NSLayoutConstraint.activate([
            usernameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 50),
            usernameTextField.heightAnchor.constraint(equalToConstant: 50),
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50)
        ])
    }
    
    func configureButton() {
        view.addSubview(getFollowersButtom)
        
        // The target object—that is, the object whose action method is called.
        getFollowersButtom.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            getFollowersButtom.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            getFollowersButtom.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            getFollowersButtom.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50)
        ])
    }
    
    @objc func buttonTapped() {
        pushFollowersView()
    }
    
    func configureKeyboardDismiss() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    func pushFollowersView() {
        guard !(usernameTextField.text?.isEmpty)! else {
            presentAlert(
                title: "Username cannot be empty",
                description: "Oops! Please enter username in the text field in the middle of the screen. ",
                buttonText: "OK")
            return
        }
        let followersViewController = FollowersViewController()
        followersViewController.username = usernameTextField.text!
        navigationController?.pushViewController(followersViewController, animated: true)
    }
}

extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pushFollowersView()
        return true
    }
}
