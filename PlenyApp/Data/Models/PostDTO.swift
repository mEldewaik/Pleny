//
//  PostDTO.swift
//  PlenyApp
//
//  Created by Mohamed Eldewaik on 07/05/2025.
//

import Foundation

struct PostDTO: Codable {
    let id: Int
    let title: String
    let body: String
    let tags: [String]
    let reactions: ReactionsDTO
    let views: Int
    let userId: Int

    func toDomain() -> Post {
        Post(
            id: id,
            title: title,
            body: body,
            tags: tags,
            likes: reactions.likes,
            dislikes: reactions.dislikes,
            views: views,
            userId: userId
        )
    }
}

struct ReactionsDTO: Codable {
    let likes: Int
    let dislikes: Int
}

