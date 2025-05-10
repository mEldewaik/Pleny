//
//  FetchPostsUseCaseType.swift
//  PlenyApp
//
//  Created by Mohamed Eldewaik on 10/05/2025.
//

import Combine

protocol FetchPostsUseCaseType {
    func execute(page: Int, limit: Int) -> AnyPublisher<[Post], Error>
}

