//
//  MockUserSessionManager.swift
//  PlenyAppTests
//
//  Created by Mohamed Eldewaik on 10/05/2025.
//

@testable import PlenyApp

final class MockUserSessionManager: UserSessionManagerProtocol {
    private(set) var saveCalled = false
    private(set) var clearCalled = false
    private(set) var savedUser: User?

    var accessToken: String? = "mockAccessToken"
    var username: String? = "mockUsername"
    var userId: Int? = 1
    var isLoggedIn: Bool = true

    func save(user: User) {
        saveCalled = true
        savedUser = user
        accessToken = user.accessToken
        username = user.username
        userId = user.id
        isLoggedIn = true
    }

    func fetchUser() -> User? {
        return savedUser
    }

    func clearUser() {
        clearCalled = true
        savedUser = nil
        accessToken = nil
        username = nil
        userId = nil
        isLoggedIn = false
    }
}


