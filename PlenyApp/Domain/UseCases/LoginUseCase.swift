//
//  LoginUseCase.swift
//  PlenyApp
//
//  Created by Mohamed Eldewaik on 07/05/2025.
//

import Foundation
import Combine

final class LoginUseCase {
    private let repository: AuthRepository

    init(repository: AuthRepository) {
        self.repository = repository
    }

    func execute(username: String, password: String) -> AnyPublisher<User, Error> {
        repository.login(username: username, password: password)
    }
}

