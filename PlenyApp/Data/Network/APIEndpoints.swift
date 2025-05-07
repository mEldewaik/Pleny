//
//  APIEndpoints.swift
//  PlenyApp
//
//  Created by Mohamed Eldewaik on 07/05/2025.
//

import Foundation

enum APIEndpoints {
    static let baseURL = "https://dummyjson.com"
    
    static func login() -> String {
        return "\(baseURL)/auth/login"
    }

    static func fetchPosts(skip: Int, limit: Int) -> String {
        return "\(baseURL)/posts?skip=\(skip)&limit=\(limit)"
    }

    static func searchPosts(query: String, skip: Int, limit: Int) -> String {
        return "\(baseURL)/posts/search?q=\(query)&skip=\(skip)&limit=\(limit)"
    }
}
