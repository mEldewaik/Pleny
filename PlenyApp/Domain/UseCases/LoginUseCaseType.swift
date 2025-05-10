//
//  LoginUseCaseType.swift
//  PlenyApp
//
//  Created by Mohamed Eldewaik on 10/05/2025.
//

import Combine

protocol LoginUseCaseType {
    func execute(username: String, password: String) -> AnyPublisher<User, Error>
}

