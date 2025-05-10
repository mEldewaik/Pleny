//
//  MockSearchPostsUseCase.swift
//  PlenyAppTests
//
//  Created by Mohamed Eldewaik on 10/05/2025.
//

import Combine
@testable import PlenyApp

final class MockSearchPostsUseCase: SearchPostsUseCaseType {
    var returnedPosts: [Post] = []

    func execute(query: String, page: Int, limit: Int) -> AnyPublisher<[Post], Error> {
        return Just(returnedPosts)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}

