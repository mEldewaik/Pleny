//
//  PostsResponseDTO.swift
//  PlenyApp
//
//  Created by Mohamed Eldewaik on 07/05/2025.
//

import Foundation

struct PostsResponseDTO: Codable {
    let posts: [PostDTO]
    let total: Int
    let skip: Int
    let limit: Int
}

