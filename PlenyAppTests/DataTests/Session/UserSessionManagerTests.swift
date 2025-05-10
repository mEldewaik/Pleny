//
//  UserSessionManagerTests.swift
//  PlenyAppTests
//
//  Created by Mohamed Eldewaik on 10/05/2025.
//

import XCTest
@testable import PlenyApp

final class UserSessionManagerTests: XCTestCase {

    var sut: UserSessionManager!
    let defaults = UserDefaults(suiteName: "TestDefaults")!

    override func setUp() {
        super.setUp()
        // Reset test-specific UserDefaults
        defaults.removePersistentDomain(forName: "TestDefaults")

        // Inject test UserDefaults into the real session manager
        sut = UserSessionManager()
        sut.setDefaults(defaults) // Custom helper we'll define below
    }

    override func tearDown() {
        defaults.removePersistentDomain(forName: "TestDefaults")
        sut = nil
        super.tearDown()
    }

    func testSaveAndFetchUser_ShouldReturnSavedUser() {
        // Given
        let user = User.mock

        // When
        sut.save(user: user())
        let fetched = sut.fetchUser()

        // Then
        XCTAssertEqual(fetched?.id, user().id)
        XCTAssertEqual(fetched?.username, user().username)
        XCTAssertEqual(sut.isLoggedIn, true)
    }

    func testClearUser_ShouldResetSession() {
        // Given
        sut.save(user: User.mock())

        // When
        sut.clearUser()

        // Then
        XCTAssertNil(sut.fetchUser())
        XCTAssertNil(sut.accessToken)
        XCTAssertFalse(sut.isLoggedIn)
    }
}

