//
//  LoginUseCaseTests.swift
//  PlenyAppTests
//
//  Created by Mohamed Eldewaik on 10/05/2025.
//

import XCTest
import Combine
@testable import PlenyApp

final class LoginUseCaseTests: XCTestCase {

    private var sut: LoginUseCase!
    private var mockRepository: MockAuthRepository!
    private var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        mockRepository = MockAuthRepository()
        sut = LoginUseCase(repository: mockRepository)
        cancellables = []
    }

    override func tearDown() {
        cancellables = nil
        mockRepository = nil
        sut = nil
        super.tearDown()
    }

    func testLogin_Success_ReturnsUser() {
        let expectedUser = User.mock()
        mockRepository.returnedUser = expectedUser
        let expectation = self.expectation(description: "Should return user")

        var receivedUser: User?
        sut.execute(username: "test", password: "1234")
            .sink(receiveCompletion: { _ in },
                  receiveValue: { user in
                      receivedUser = user
                      expectation.fulfill()
                  })
            .store(in: &cancellables)

        waitForExpectations(timeout: 1.0)
        XCTAssertTrue(mockRepository.loginCalled)
        XCTAssertEqual(receivedUser?.id, expectedUser.id)
    }

    func testLogin_Failure_ReturnsError() {
        let expectation = self.expectation(description: "Should return error")
        mockRepository.returnedError = NSError(domain: "Test", code: 401)

        var capturedError: Error?
        sut.execute(username: "fail", password: "fail")
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    capturedError = error
                    expectation.fulfill()
                }
            }, receiveValue: { _ in })
            .store(in: &cancellables)

        waitForExpectations(timeout: 1.0)
        XCTAssertNotNil(capturedError)
    }
}

