//
//  PostsWrapperView.swift
//  PlenyApp
//
//  Created by Mohamed Eldewaik on 10/05/2025.
//

import SwiftUI

struct PostsWrapperView: View {
    let postsCoordinator: PostsCoordinator
    let searchCoordinator: SearchCoordinator

    @State private var isPresentingSearch = false

    var body: some View {
        NavigationView {
            postsCoordinator.makeView(onSearchTap: {
                isPresentingSearch = true
            })
            .sheet(isPresented: $isPresentingSearch) {
                searchCoordinator.makeView()
            }
        }
    }
}

