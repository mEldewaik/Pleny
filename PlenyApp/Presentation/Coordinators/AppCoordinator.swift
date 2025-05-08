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

    private let loginUseCase: LoginUseCase
    private let postsUseCase: FetchPostsUseCase

    init(loginUseCase: LoginUseCase, postsUseCase: FetchPostsUseCase) {
        self.loginUseCase = loginUseCase
        self.postsUseCase = postsUseCase
    }

    @ViewBuilder
    func start() -> some View {
        LoginCoordinator(loginUseCase: loginUseCase, onLoginSuccess: {
            self.isAuthenticated = true
        }).makeView()
    }
}

