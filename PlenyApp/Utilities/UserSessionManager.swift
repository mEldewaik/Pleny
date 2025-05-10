//
//  UserSessionManager.swift
//  PlenyApp
//
//  Created by Mohamed Eldewaik on 08/05/2025.
//

import Foundation

final class UserSessionManager: UserSessionManagerProtocol {

    // MARK: - Singleton (Injectable for tests)
    static var shared: UserSessionManagerProtocol = UserSessionManager()

    private var defaults: UserDefaults

    private enum Keys {
        static let userId = "userId"
        static let username = "username"
        static let accessToken = "accessToken"
        static let refreshToken = "refreshToken"
        static let isLoggedIn = "isLoggedIn"
    }

    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
    }

    // MARK: - Save User
    func save(user: User) {
        defaults.set(user.id, forKey: Keys.userId)
        defaults.set(user.username, forKey: Keys.username)
        defaults.set(user.accessToken, forKey: Keys.accessToken)
        defaults.set(user.refreshToken, forKey: Keys.refreshToken)
        defaults.set(true, forKey: Keys.isLoggedIn)
    }
    
    #if DEBUG
    func setDefaults(_ customDefaults: UserDefaults) {
        // Used only for testing
        self.defaults = customDefaults
    }
    #endif

    // MARK: - Fetch User
    func fetchUser() -> User? {
        guard let username = defaults.string(forKey: Keys.username),
              let accessToken = defaults.string(forKey: Keys.accessToken),
              let refreshToken = defaults.string(forKey: Keys.refreshToken) else {
            return nil
        }

        let id = defaults.integer(forKey: Keys.userId)

        return User(
            id: id,
            username: username,
            email: "", // If needed, you can store and retrieve email as well
            firstName: "",
            lastName: "",
            image: "",
            accessToken: accessToken,
            refreshToken: refreshToken
        )
    }

    // MARK: - Clear Session
    func clearUser() {
        defaults.removeObject(forKey: Keys.userId)
        defaults.removeObject(forKey: Keys.username)
        defaults.removeObject(forKey: Keys.accessToken)
        defaults.removeObject(forKey: Keys.refreshToken)
        defaults.set(false, forKey: Keys.isLoggedIn)
    }

    // MARK: - Accessors
    var accessToken: String? {
        defaults.string(forKey: Keys.accessToken)
    }

    var username: String? {
        defaults.string(forKey: Keys.username)
    }

    var userId: Int? {
        let id = defaults.integer(forKey: Keys.userId)
        return id == 0 ? nil : id
    }

    var isLoggedIn: Bool {
        defaults.bool(forKey: Keys.isLoggedIn)
    }
}


