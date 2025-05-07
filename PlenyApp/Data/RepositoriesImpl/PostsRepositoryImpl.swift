//
//  PostsRepositoryImpl.swift
//  PlenyApp
//
//  Created by Mohamed Eldewaik on 07/05/2025.
//

import Foundation
import Combine

final class PostsRepositoryImpl: PostsRepository {
    func fetchPosts(page: Int, limit: Int) -> AnyPublisher<[Post], Error> {
        let skip = page * limit
        let url = APIEndpoints.fetchPosts(skip: skip, limit: limit)

        return APIClient.shared
            .get(urlString: url)
            .map { (response: PostsResponseDTO) in
                response.posts.map { $0.toDomain() }
            }
            .eraseToAnyPublisher()
    }

    func searchPosts(query: String, page: Int, limit: Int) -> AnyPublisher<[Post], Error> {
        let skip = page * limit
        let url = APIEndpoints.searchPosts(query: query, skip: skip, limit: limit)

        return APIClient.shared
            .get(urlString: url)
            .map { (response: PostsResponseDTO) in
                response.posts.map { $0.toDomain() }
            }
            .eraseToAnyPublisher()
    }
}

