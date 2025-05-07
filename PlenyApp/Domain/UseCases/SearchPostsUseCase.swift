//
//  SearchPostsUseCase.swift
//  PlenyApp
//
//  Created by Mohamed Eldewaik on 07/05/2025.
//

import Foundation
import Combine

final class SearchPostsUseCase {
    private let repository: PostsRepository

    init(repository: PostsRepository) {
        self.repository = repository
    }

    func execute(query: String, page: Int, limit: Int) -> AnyPublisher<[Post], Error> {
        repository.searchPosts(query: query, page: page, limit: limit)
    }
}

