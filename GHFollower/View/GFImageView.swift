//
//  GFImageView.swift
//  GHFollower
//
//  Created by Yongqi Xu on 2020-09-09.
//  Copyright © 2020 Yongqi Xu. All rights reserved.
//

import UIKit

class GFImageView: UIImageView {
    
    let placeholderImage = UIImage(named: "avatar-placeholder")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        image = placeholderImage
        layer.cornerRadius = 10
        layer.cornerCurve = .continuous
        clipsToBounds = true
        contentMode = .scaleAspectFit
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalTo: widthAnchor).isActive = true
    }
    
    func updateImage(from urlString: String) {
        
        if let image = NetworkManager.shared.cache.object(forKey: NSString(string: urlString)) {
            self.image = image
            return
        }
        
        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let self = self else {return}
            if error != nil { return }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return }
            guard let data = data else { return }
            
            guard let image = UIImage(data: data) else { return }
            NetworkManager.shared.cache.setObject(image, forKey: NSString(string: urlString))
            
            DispatchQueue.main.async {
                self.image = image
            }
        }
        
        task.resume()
        
    }
    
}
