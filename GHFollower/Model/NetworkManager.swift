//
//  NetworkManager.swift
//  GHFollower
//
//  Created by Yongqi Xu on 2020-09-08.
//  Copyright © 2020 Yongqi Xu. All rights reserved.
//

import UIKit

class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    
    private let baseURL = "https://api.github.com/users/"
    var cache = NSCache<NSString, UIImage>()
    
    func getFollowers(username: String, page: Int, completion: @escaping (Result<[Follower], ErrorMessage>) -> Void) {
        guard let url = URL(string: baseURL + "\(username)/followers?per_page=100&page=\(page)") else {
            completion(.failure(.invalidUsername))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let _ = error {
                completion(.failure(.unableToComplete))
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode([Follower].self, from: data)
                completion(.success(followers))
            } catch {
                completion(.failure(.invalidData))
            }
        }
        task.resume()
    }
    
    func getUser(username: String, completion: @escaping (Result<User, ErrorMessage>) -> Void) {
        guard let url = URL(string: baseURL + "\(username)") else {
            completion(.failure(.invalidUsername))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let _ = error {
                completion(.failure(.unableToComplete))
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                decoder.dateDecodingStrategy = .iso8601
                let user = try decoder.decode(User.self, from: data)
                completion(.success(user))
            } catch {
                completion(.failure(.invalidData))
            }
        }
        task.resume()
    }
}

enum ErrorMessage: String, Error {
    case invalidUsername = "The username created an invalid request. Please try again."
    case unableToComplete = "Unable to complete your request. Plaease check your internet connection."
    case invalidResponse = "Invalid response from the server. Please try again."
    case invalidData = "The data received from the server was invalid. Please try again."
    case alreadyFavorited = "This user has already been favorited before."
}
