//
//  SearchViewModel.swift
//  PlenyApp
//
//  Created by Mohamed Eldewaik on 10/05/2025.
//

import Foundation
import Combine

final class SearchViewModel: ObservableObject {
    @Published var query: String = ""
    @Published var results: [Post] = []
    @Published var isLoading: Bool = false
    
    private let useCase: SearchPostsUseCaseType
    private var cancellables = Set<AnyCancellable>()
    
    init(useCase: SearchPostsUseCaseType) {
        self.useCase = useCase
        bindQuery()
    }
    
    private func bindQuery() {
        $query
            .debounce(for: .milliseconds(400), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink { [weak self] keyword in
                self?.performSearch(with: keyword)
            }
            .store(in: &cancellables)
    }
    
    private func performSearch(with keyword: String) {
        guard !keyword.trimmingCharacters(in: .whitespaces).isEmpty else {
            results = []
            return
        }
        
        isLoading = true
        
        useCase.execute(query: keyword, page: 0, limit: 20)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
            } receiveValue: { [weak self] posts in
                self?.results = posts
            }
            .store(in: &cancellables)
    }
}

