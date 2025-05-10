//
//  LoginCoordinator.swift
//  PlenyApp
//
//  Created by Mohamed Eldewaik on 08/05/2025.
//

import SwiftUI
import Combine

final class LoginCoordinator {
    private let loginUseCase: LoginUseCaseType
    private let onLoginSuccess: () -> Void
    private var cancellables = Set<AnyCancellable>()

    init(loginUseCase: LoginUseCaseType, onLoginSuccess: @escaping () -> Void) {
        self.loginUseCase = loginUseCase
        self.onLoginSuccess = onLoginSuccess
    }

    func makeView() -> some View {
        let viewModel = LoginViewModel(loginUseCase: loginUseCase)

        viewModel.$isLoginSuccessful
            .removeDuplicates()
            .filter { $0 }
            .sink { [weak self] _ in
                self?.onLoginSuccess()
            }
            .store(in: &cancellables)

        return LoginView(viewModel: viewModel)
    }
}

