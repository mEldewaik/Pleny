//
//  UserSessionManagerProtocol.swift
//  PlenyApp
//
//  Created by Mohamed Eldewaik on 10/05/2025.
//

import Foundation

protocol UserSessionManagerProtocol {
    func save(user: User)
    func fetchUser() -> User?
    func clearUser()
    
    var isLoggedIn: Bool { get }
    var accessToken: String? { get }
    var username: String? { get }
    var userId: Int? { get }
}


