//
//  LoginView.swift
//  PlenyApp
//
//  Created by Mohamed Eldewaik on 08/05/2025.
//

import SwiftUI
import Combine

struct LoginView: View {
    
    @ObservedObject var viewModel: LoginViewModel
    
    var body: some View {
        VStack(spacing: 24) {
            Image("login_image")
                .resizable()
                .scaledToFill()
                .frame(height: UIScreen.main.bounds.height * 0.5)
                .clipped()
        
            
            VStack(spacing: 16) {
                
                // Welcome Text
                Text("Welcome")
                    .font(.title2)
                    .bold()
                    .foregroundColor(AppColor.primary)

                // Username Field
                VStack(alignment: .leading, spacing: 6) {
                    Text("User Name")
                        .font(.subheadline)
                        .bold()
                        .foregroundColor(AppColor.grey700)
                    
                    TextField("Enter your user name", text: $viewModel.username)
                        .padding()
                        .background(Color(.white))
                        .cornerRadius(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(AppColor.grey300, lineWidth: 1)
                        )
                }
                
                // Password Field
                VStack(alignment: .leading, spacing: 6) {
                    Text("Password")
                        .font(.subheadline)
                        .bold()
                        .foregroundColor(AppColor.grey700)
                    
                    SecureField("Enter your password", text: $viewModel.password)
                        .padding()
                        .background(Color(.white))
                        .cornerRadius(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(AppColor.grey300, lineWidth: 1)
                        )
                }
            }
            .padding(16.0)
            
            // Sign in button
            Button(action: {
                viewModel.login()
            }) {
                if viewModel.isLoading {
                    ProgressView()
                        .tint(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                } else {
                    Text("Sign in")
                        .foregroundColor(.white)
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                }
            }
            .background(viewModel.isFormValid ? AppColor.primary : AppColor.primary.opacity(0.4))
            .cornerRadius(32)
            .disabled(!viewModel.isFormValid)
            .padding(.horizontal, 16)
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .edgesIgnoringSafeArea(.top)
        
        .onReceive(viewModel.$isLoginSuccessful) { success in
            if success {
                print("🎉 Navigating after successful login... \(UserSessionManager.shared.username)")
            }
        }
        
    }
}

#Preview {
    let authRepository = AuthRepositoryImpl()
    let loginUseCase = LoginUseCase(repository: authRepository)
    let viewModel = LoginViewModel(loginUseCase: loginUseCase)
    LoginView(viewModel: viewModel)
}

