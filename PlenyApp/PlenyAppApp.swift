//
//  PlenyAppApp.swift
//  PlenyApp
//
//  Created by Mohamed Eldewaik on 07/05/2025.
//

import SwiftUI

@main
struct PlenyApp: App {
    @StateObject private var coordinator: AppCoordinator

    init() {
        // Setup Use Cases
        let authRepo = AuthRepositoryImpl()
        let postsRepo = PostsRepositoryImpl()

        let loginUseCase = LoginUseCase(repository: authRepo)
        let postsUseCase = FetchPostsUseCase(repository: postsRepo)

        _coordinator = StateObject(wrappedValue: AppCoordinator(
            loginUseCase: loginUseCase,
            postsUseCase: postsUseCase
        ))
    }

    var body: some Scene {
        WindowGroup {
            coordinator.start()
        }
    }
}

