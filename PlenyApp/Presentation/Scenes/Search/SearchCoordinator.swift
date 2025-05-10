//
//  SearchCoordinator.swift
//  PlenyApp
//
//  Created by Mohamed Eldewaik on 10/05/2025.
//

import SwiftUI

final class SearchCoordinator {
    private let useCase: SearchPostsUseCase

    init(useCase: SearchPostsUseCase) {
        self.useCase = useCase
    }

    func makeView() -> some View {
        let viewModel = SearchViewModel(useCase: useCase)
        return SearchView(viewModel: viewModel)
    }
}

