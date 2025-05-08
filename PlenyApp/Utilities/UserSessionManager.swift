//
//  UserSessionManager.swift
//  PlenyApp
//
//  Created by Mohamed Eldewaik on 08/05/2025.
//

import Foundation

final class UserSessionManager {
    static let shared = UserSessionManager()

    private let defaults = UserDefaults.standard

    private enum Keys {
        static let userId = "userId"
        static let username = "username"
        static let accessToken = "accessToken"
        static let refreshToken = "refreshToken"
        static let isLoggedIn = "isLoggedIn"
    }

    private init() {}

    // MARK: - Save
    func save(user: User) {
        defaults.set(user.id, forKey: Keys.userId)
        defaults.set(user.username, forKey: Keys.username)
        defaults.set(user.accessToken, forKey: Keys.accessToken)
        defaults.set(user.refreshToken, forKey: Keys.refreshToken)
        defaults.set(true, forKey: Keys.isLoggedIn)
    }

    // MARK: - Accessors
    var accessToken: String? {
        defaults.string(forKey: Keys.accessToken)
    }
    
    var username: String? {
        defaults.string(forKey: Keys.username)
    }

    var userId: Int? {
        defaults.integer(forKey: Keys.userId)
    }

    var isLoggedIn: Bool {
        defaults.bool(forKey: Keys.isLoggedIn)
    }

    // MARK: - Logout
    func clearSession() {
        defaults.removeObject(forKey: Keys.userId)
        defaults.removeObject(forKey: Keys.username)
        defaults.removeObject(forKey: Keys.accessToken)
        defaults.removeObject(forKey: Keys.refreshToken)
        defaults.set(false, forKey: Keys.isLoggedIn)
    }
}

