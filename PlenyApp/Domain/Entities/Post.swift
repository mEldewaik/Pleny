//
//  Post.swift
//  PlenyApp
//
//  Created by Mohamed Eldewaik on 07/05/2025.
//

import Foundation

struct Post: Identifiable, Equatable {
    let id: Int
    let title: String
    let body: String
    let tags: [String]
    let likes: Int
    let dislikes: Int
    let views: Int
    let userId: Int
}

extension Post {
    static func mock(
        id: Int = 1,
        title: String = "Test Title",
        body: String = "Test Body with keyword",
        tags: [String] = ["test", "mock"],
        likes: Int = 123,
        dislikes: Int = 4,
        views: Int = 999,
        userId: Int = 42
    ) -> Post {
        return Post(
            id: id,
            title: title,
            body: body,
            tags: tags,
            likes: likes,
            dislikes: dislikes,
            views: views,
            userId: userId
        )
    }
}



