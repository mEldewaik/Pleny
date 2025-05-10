//
//  DummySearchUseCase.swift
//  PlenyAppTests
//
//  Created by Mohamed Eldewaik on 10/05/2025.
//

import Combine
@testable import PlenyApp

final class DummySearchUseCase: SearchPostsUseCaseType {
    func execute(query: String, page: Int, limit: Int) -> AnyPublisher<[Post], Error> {
        return Just([]) // empty result
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}


