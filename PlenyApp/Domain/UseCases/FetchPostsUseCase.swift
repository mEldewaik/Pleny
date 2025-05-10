//
//  FetchPostsUseCase.swift
//  PlenyApp
//
//  Created by Mohamed Eldewaik on 07/05/2025.
//

import Foundation
import Combine

final class FetchPostsUseCase: FetchPostsUseCaseType {
    private let repository: PostsRepository

    init(repository: PostsRepository) {
        self.repository = repository
    }

    func execute(page: Int, limit: Int) -> AnyPublisher<[Post], Error> {
        repository.fetchPosts(page: page, limit: limit)
    }
}

