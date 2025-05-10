//
//  LoginViewModelTests.swift
//  PlenyAppTests
//
//  Created by Mohamed Eldewaik on 10/05/2025.
//

import XCTest
import Combine
@testable import PlenyApp

final class LoginViewModelTests: XCTestCase {

    private var viewModel: LoginViewModel!
    private var mockUseCase: MockLoginUseCase!
    private var mockSessionManager: MockUserSessionManager!
    private var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        mockUseCase = MockLoginUseCase()
        mockSessionManager = MockUserSessionManager()
        UserSessionManager.shared = mockSessionManager // Inject mock singleton
        viewModel = LoginViewModel(loginUseCase: mockUseCase)
        cancellables = []
    }

    override func tearDown() {
        cancellables = nil
        viewModel = nil
        mockUseCase = nil
        mockSessionManager = nil
        super.tearDown()
    }

    func testLoginSuccess_ShouldSaveUserAndClearError() {
        // Given
        let user = User.mock()
        mockUseCase.returnedUser = user

        let expectation = expectation(description: "Login should succeed")

        viewModel.$isLoading
            .dropFirst()
            .sink { isLoading in
                if isLoading == false {
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)

        // When
        viewModel.username = "test"
        viewModel.password = "1234"
        viewModel.login()

        // Then
        waitForExpectations(timeout: 1.0)
        XCTAssertNil(viewModel.errorMessage)
        XCTAssertTrue(mockSessionManager.saveCalled)
        XCTAssertEqual(mockSessionManager.savedUser?.id, user.id)
    }

    func testLoginFailure_ShouldSetErrorMessage() {
        // Given
        let error = NSError(domain: "Test", code: 401, userInfo: [NSLocalizedDescriptionKey: "Invalid credentials"])
        mockUseCase.returnedError = error

        let expectation = expectation(description: "Login should fail")

        viewModel.$errorMessage
            .dropFirst()
            .sink { message in
                if message != nil {
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)

        // When
        viewModel.username = "wrong"
        viewModel.password = "wrong"
        viewModel.login()

        // Then
        waitForExpectations(timeout: 1.0)
        XCTAssertEqual(viewModel.errorMessage, "Invalid credentials")
        XCTAssertFalse(mockSessionManager.saveCalled)
    }
}

