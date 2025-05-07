//
//  Post.swift
//  PlenyApp
//
//  Created by Mohamed Eldewaik on 07/05/2025.
//

import Foundation

struct Post: Identifiable {
    let id: Int
    let title: String
    let body: String
    let tags: [String]
    let likes: Int
    let dislikes: Int
    let views: Int
    let userId: Int
}

