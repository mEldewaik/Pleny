//
//  PostsRepository.swift
//  PlenyApp
//
//  Created by Mohamed Eldewaik on 07/05/2025.
//

import Foundation
import Combine

protocol PostsRepository {
    func fetchPosts(page: Int, limit: Int) -> AnyPublisher<[Post], Error>
    func searchPosts(query: String, page: Int, limit: Int) -> AnyPublisher<[Post], Error>
}

