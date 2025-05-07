//
//  AuthRepositoryImpl.swift
//  PlenyApp
//
//  Created by Mohamed Eldewaik on 07/05/2025.
//

import Foundation
import Combine

final class AuthRepositoryImpl: AuthRepository {
    func login(username: String, password: String) -> AnyPublisher<User, Error> {
        let body = [
            "username": username,
            "password": password
        ]

        return APIClient.shared
            .post(urlString: APIEndpoints.login(), body: body)
            .map { (dto: UserDTO) in
                dto.toDomain()
            }
            .eraseToAnyPublisher()
    }
}

