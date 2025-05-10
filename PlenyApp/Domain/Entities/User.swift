//
//  User.swift
//  PlenyApp
//
//  Created by Mohamed Eldewaik on 07/05/2025.
//

import Foundation

struct User: Identifiable {
    let id: Int
    let username: String
    let email: String
    let firstName: String
    let lastName: String
    let image: String
    let accessToken: String
    let refreshToken: String
}

extension User {
    static func mock() -> User {
        return User(
            id: 1,
            username: "testuser",
            email: "test@pleny.com",
            firstName: "Test",
            lastName: "User",
            image: "",
            accessToken: "abc123",
            refreshToken: "refresh123"
        )
    }
}


