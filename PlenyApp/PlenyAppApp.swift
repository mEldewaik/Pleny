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
        let authRepo = AuthRepositoryImpl()
        let postsRepo = PostsRepositoryImpl()

        let loginUseCase = LoginUseCase(repository: authRepo)
        let fetchPostsUseCase = FetchPostsUseCase(repository: postsRepo)
        let searchPostsUseCase = SearchPostsUseCase(repository: postsRepo)

        _coordinator = StateObject(wrappedValue:
            AppCoordinator(
                loginUseCase: loginUseCase,
                postsUseCase: fetchPostsUseCase,
                searchUseCase: searchPostsUseCase
            )
        )
    }

    var body: some Scene {
        WindowGroup {
            coordinator.start()
        }
    }
}


