//
//  PostsViewModel.swift
//  PlenyApp
//
//  Created by Mohamed Eldewaik on 08/05/2025.
//

import Foundation
import Combine

final class PostsViewModel: ObservableObject {
    @Published var posts: [Post] = []
    @Published var isLoading: Bool = false
    @Published var searchQuery: String = ""
    @Published var hasMorePages: Bool = true

    private let fetchPostsUseCase: FetchPostsUseCase
    private let searchPostsUseCase: SearchPostsUseCase
    private var cancellables = Set<AnyCancellable>()

    private var currentPage = 0
    private let pageSize = 20
    private var isSearching = false

    init(fetchUseCase: FetchPostsUseCase, searchUseCase: SearchPostsUseCase) {
        self.fetchPostsUseCase = fetchUseCase
        self.searchPostsUseCase = searchUseCase

        bindSearch()
    }

    func loadInitialPosts() {
        currentPage = 0
        posts = []
        hasMorePages = true
        isSearching = false
        fetchPosts()
    }

    func loadMorePostsIfNeeded(currentItem: Post) {
        guard !isLoading,
              hasMorePages,
              posts.last?.id == currentItem.id else { return }

        currentPage += 1
        isSearching ? searchPosts() : fetchPosts()
    }

    private func fetchPosts() {
        isLoading = true
        fetchPostsUseCase.execute(page: currentPage, limit: pageSize)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                if case .failure(_) = completion {
                    self?.hasMorePages = false
                }
            } receiveValue: { [weak self] newPosts in
                self?.posts.append(contentsOf: newPosts)
                self?.hasMorePages = newPosts.count == self?.pageSize
            }
            .store(in: &cancellables)
    }

    private func searchPosts() {
        isLoading = true
        searchPostsUseCase.execute(query: searchQuery, page: currentPage, limit: pageSize)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                if case .failure(_) = completion {
                    self?.hasMorePages = false
                }
            } receiveValue: { [weak self] results in
                self?.posts.append(contentsOf: results)
                self?.hasMorePages = results.count == self?.pageSize
            }
            .store(in: &cancellables)
    }

    private func bindSearch() {
        $searchQuery
            .debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink { [weak self] text in
                guard let self = self else { return }
                self.currentPage = 0
                self.posts = []
                self.hasMorePages = true
                self.isSearching = !text.isEmpty
                self.isSearching ? self.searchPosts() : self.fetchPosts()
            }
            .store(in: &cancellables)
    }
}

