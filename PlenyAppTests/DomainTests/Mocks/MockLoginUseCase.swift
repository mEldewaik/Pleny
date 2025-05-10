//
//  MockLoginUseCase.swift
//  PlenyAppTests
//
//  Created by Mohamed Eldewaik on 10/05/2025.
//

import Combine
@testable import PlenyApp

final class MockLoginUseCase: LoginUseCaseType {
    var returnedUser: User?
    var returnedError: Error?

    func execute(username: String, password: String) -> AnyPublisher<User, Error> {
        if let error = returnedError {
            return Fail(error: error).eraseToAnyPublisher()
        }
        return Just(returnedUser ?? User.mock())
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}

