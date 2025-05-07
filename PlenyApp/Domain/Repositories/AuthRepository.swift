//
//  AuthRepository.swift
//  PlenyApp
//
//  Created by Mohamed Eldewaik on 07/05/2025.
//

import Foundation
import Combine

protocol AuthRepository {
    func login(username: String, password: String) -> AnyPublisher<User, Error>
}

