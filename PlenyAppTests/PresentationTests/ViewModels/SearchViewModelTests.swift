//
//  SearchViewModelTests.swift
//  PlenyAppTests
//
//  Created by Mohamed Eldewaik on 10/05/2025.
//

import XCTest
import Combine
@testable import PlenyApp

final class SearchViewModelTests: XCTestCase {

    private var viewModel: SearchViewModel!
    private var mockUseCase: MockSearchPostsUseCase!
    private var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        mockUseCase = MockSearchPostsUseCase()
        viewModel = SearchViewModel(useCase: mockUseCase)
        cancellables = []
    }

    override func tearDown() {
        cancellables = nil
        viewModel = nil
        mockUseCase = nil
        super.tearDown()
    }

    func testSearch_WithQuery_ShouldReturnResults() {
        // Given
        let expectedPosts = [
            Post.mock(id: 1),
            Post.mock(id: 2)
        ]
        mockUseCase.returnedPosts = expectedPosts

        let expectation = self.expectation(description: "Should return search results")

        viewModel.$results
            .dropFirst()
            .sink { posts in
                if posts == expectedPosts {
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)

        // When
        viewModel.query = "test"

        // Then
        waitForExpectations(timeout: 1.5)
        XCTAssertTrue(viewModel.isLoading == false)
    }

    func testSearch_EmptyQuery_ShouldClearResults() {
        // Given
        viewModel.results = [.mock()]
        let expectation = self.expectation(description: "Should clear results")

        viewModel.$results
            .dropFirst()
            .sink { posts in
                if posts.isEmpty {
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)

        // When
        viewModel.query = ""

        // Then
        waitForExpectations(timeout: 1.0)
    }
}
