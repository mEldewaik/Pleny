//
//  PostsCoordinator.swift
//  PlenyApp
//
//  Created by Mohamed Eldewaik on 08/05/2025.
//

import SwiftUI

final class PostsCoordinator {
    private let useCase: FetchPostsUseCase
    private let searchUseCase: SearchPostsUseCase

    init(useCase: FetchPostsUseCase, searchUseCase: SearchPostsUseCase) {
        self.useCase = useCase
        self.searchUseCase = searchUseCase
    }

    func makeView(onSearchTap: @escaping () -> Void) -> some View {
        let viewModel = PostsViewModel(fetchUseCase: useCase, searchUseCase: searchUseCase)
        return PostsView(viewModel: viewModel, onSearchTap: onSearchTap)
    }
}


