//
//  PersistenceManager.swift
//  GHFollower
//
//  Created by Yongqi Xu on 2020-09-22.
//  Copyright © 2020 Yongqi Xu. All rights reserved.
//

import Foundation

enum PersistenceAction {
    case add, remove
}

enum PersistenceManager {
    
    enum Key {
        static let favorites = "favorites"
    }
    
    static let standard = UserDefaults.standard
    
    static func update(favorite: Follower, actionType: PersistenceAction) -> ErrorMessage? {
        var errorMessage: ErrorMessage? = nil
        retrive { result in
            switch result {
            case .success(let favorites):
                var favorites = favorites
                
                switch actionType {
                case .add:
                    guard !favorites.contains(favorite) else {
                        errorMessage = .alreadyFavorited
                        return
                    }
                    favorites.append(favorite)
                case .remove:
                    favorites.removeAll { $0.login == favorite.login }
                }
                
                errorMessage = save(favorites: favorites)
                
            case .failure(let error):
                errorMessage = error
            }
        }
        return errorMessage
    }
    
    static func retrive(completion: @escaping (Result<[Follower], ErrorMessage>) -> Void) {
        
        guard let data = standard.object(forKey: Key.favorites) as? Data else {
            completion(.success([]))
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let favorites = try decoder.decode([Follower].self, from: data)
            completion(.success(favorites))
        } catch {
            completion(.failure(.invalidData))
            return
        }
        
    }
    
    static func save(favorites: [Follower]) -> ErrorMessage? {
        
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(favorites)
            standard.set(data, forKey: Key.favorites)
            return nil
        } catch {
            return .invalidData
        }
        
    }
    
    static func contains(user: Follower) -> Bool {
        guard let data = standard.object(forKey: Key.favorites) as? Data else {
            return false
        }
        
        do {
            let decoder = JSONDecoder()
            let favorites = try decoder.decode([Follower].self, from: data)
            return favorites.contains(user)
        } catch {
            return false
        }
    }
}
