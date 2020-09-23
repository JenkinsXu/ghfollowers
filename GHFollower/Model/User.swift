//
//  User.swift
//  GHFollower
//
//  Created by Yongqi Xu on 2020-09-08.
//  Copyright © 2020 Yongqi Xu. All rights reserved.
//

import Foundation

struct User: Codable {
    var login: String
    var avatarUrl: String
    var name: String?
    var location: String?
    var bio: String?
    var publicRepos: Int
    var publicGists: Int
    var htmlUrl: String
    var following: Int
    var followers: Int
    var createdAt: Date
}
