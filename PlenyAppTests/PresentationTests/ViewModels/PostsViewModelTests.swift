//
//  PostsViewModelTests.swift
//  PlenyAppTests
//
//  Created by Mohamed Eldewaik on 10/05/2025.
//

import XCTest
import Combine
@testable import PlenyApp

final class PostsViewModelTests: XCTestCase {

    private var viewModel: PostsViewModel!
    private var mockUseCase: MockFetchPostsUseCase!
    private var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        mockUseCase = MockFetchPostsUseCase()
        viewModel = PostsViewModel(fetchUseCase: mockUseCase, searchUseCase: DummySearchUseCase())
        cancellables = []
    }

    override func tearDown() {
        cancellables = nil
        viewModel = nil
        mockUseCase = nil
        super.tearDown()
    }

    func testInitialLoad_ShouldSetPosts() {
        // Given
        let expectedPosts = [
            Post.mock(id: 1),
            Post.mock(id: 2)
        ]
        mockUseCase.returnedPosts = expectedPosts

        let expectation = expectation(description: "Should load posts")

        viewModel.$posts
            .dropFirst()
            .sink { posts in
                if posts == expectedPosts {
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)

        // When
        viewModel.loadInitialPosts()

        // Then
        waitForExpectations(timeout: 1.0)
    }

    func testPagination_ShouldAppendPosts() {
        // Given
        viewModel.posts = [Post.mock(id: 1)]
        mockUseCase.returnedPosts = [Post.mock(id: 2), Post.mock(id: 3)]

        let expectation = expectation(description: "Should append posts")

        viewModel.$posts
            .dropFirst()
            .sink { posts in
                if posts.count == 3 {
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)

        // When
        viewModel.loadMorePostsIfNeeded(currentItem: Post.mock(id: 1))

        // Then
        waitForExpectations(timeout: 1.0)
    }
}

