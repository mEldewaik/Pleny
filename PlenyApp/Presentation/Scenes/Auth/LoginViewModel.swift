//
//  LoginViewModel.swift
//  PlenyApp
//
//  Created by Mohamed Eldewaik on 08/05/2025.
//

import Foundation
import Combine

final class LoginViewModel: ObservableObject {
    // Input
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var isFormValid: Bool = false

    // Output
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var isLoginSuccessful: Bool = false


    private let loginUseCase: LoginUseCaseType
    private var cancellables = Set<AnyCancellable>()

    init(loginUseCase: LoginUseCaseType) {
        self.loginUseCase = loginUseCase
        
        // Validate input and update `isFormValid`
        Publishers.CombineLatest($username, $password)
            .map { username, password in
                return !username.trimmingCharacters(in: .whitespaces).isEmpty &&
                       !password.trimmingCharacters(in: .whitespaces).isEmpty
            }
            .assign(to: &$isFormValid)
    }

    func login() {
        isLoading = true
        errorMessage = nil

        loginUseCase.execute(username: username, password: password)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                if case let .failure(error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
            } receiveValue: { [weak self] user in
                UserSessionManager.shared.save(user: user)
                self?.isLoginSuccessful = true
            }
            .store(in: &cancellables)
    }
}



