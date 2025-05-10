//
//  AppCoordinator.swift
//  PlenyApp
//
//  Created by Mohamed Eldewaik on 08/05/2025.
//

import SwiftUI
import Combine

final class AppCoordinator: ObservableObject {
    @Published var isAuthenticated: Bool = UserSessionManager.shared.isLoggedIn

    // MARK: - Use Cases
    private let loginUseCase: LoginUseCaseType
    private let postsUseCase: FetchPostsUseCase
    private let searchUseCase: SearchPostsUseCase

    // MARK: - Coordinators
    private lazy var postsCoordinator: PostsCoordinator = {
        PostsCoordinator(
            useCase: postsUseCase,
            searchUseCase: searchUseCase
        )
    }()

    private lazy var searchCoordinator: SearchCoordinator = {
        SearchCoordinator(useCase: searchUseCase)
    }()

    init(
        loginUseCase: LoginUseCase,
        postsUseCase: FetchPostsUseCase,
        searchUseCase: SearchPostsUseCase
    ) {
        self.loginUseCase = loginUseCase
        self.postsUseCase = postsUseCase
        self.searchUseCase = searchUseCase
    }

    @ViewBuilder
    func start() -> some View {
        if isAuthenticated {
            PostsWrapperView(
                postsCoordinator: postsCoordinator,
                searchCoordinator: searchCoordinator
            )
        } else {
            LoginCoordinator(
                loginUseCase: loginUseCase,
                onLoginSuccess: {
                    self.isAuthenticated = true
                }
            ).makeView()
        }
    }
}



