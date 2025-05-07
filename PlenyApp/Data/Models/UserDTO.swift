//
//  UserDTO.swift
//  PlenyApp
//
//  Created by Mohamed Eldewaik on 07/05/2025.
//

import Foundation

struct UserDTO: Codable {
    let id: Int
    let username: String
    let email: String
    let firstName: String
    let lastName: String
    let image: String
    let accessToken: String
    let refreshToken: String

    func toDomain() -> User {
        User(
            id: id,
            username: username,
            email: email,
            firstName: firstName,
            lastName: lastName,
            image: image,
            accessToken: accessToken,
            refreshToken: refreshToken
        )
    }
}

