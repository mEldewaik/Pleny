//
//  SearchView.swift
//  PlenyApp
//
//  Created by Mohamed Eldewaik on 10/05/2025.
//

import SwiftUI

struct SearchView: View {
    @ObservedObject var viewModel: SearchViewModel
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack(spacing: 0) {
            // MARK: - Search Bar
            SearchBarView(text: $viewModel.query) {
                dismiss()
            }

            // MARK: - Results
            if viewModel.isLoading {
                Spacer()
                ProgressView()
                Spacer()
            } else if viewModel.results.isEmpty && !viewModel.query.isEmpty {
                Spacer()
                Text("No results found")
                    .foregroundColor(.gray)
                Spacer()
            } else {
                ScrollView {
                    LazyVStack(spacing: 16) {
                        ForEach(viewModel.results) { post in
                            PostCellView(post: post, highlight: viewModel.query)
                        }
                    }
                    .padding()
                }
            }
        }
    }
}

