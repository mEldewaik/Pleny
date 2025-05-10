//
//  PostsView.swift
//  PlenyApp
//
//  Created by Mohamed Eldewaik on 08/05/2025.
//

import SwiftUI

struct PostsView: View {
    @ObservedObject var viewModel: PostsViewModel
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                
                // MARK: - Top Bar
                HStack {
                    Image("LOGO") // Add your logo image to Assets
                        .resizable()
                        .frame(width: 80, height: 24)
                    
                    Spacer()
                    
                    Button(action: {
                        // Action goes here (e.g., navigate to search or print debug)
                        print("Search tapped")
                    }) {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(AppColor.grey700)
                    }
                    
                }
                .padding()
                .background(Color.white)
                .overlay(
                    Divider()
                        .background(AppColor.grey200.opacity(0.3)),
                    alignment: .bottom
                )
                
                // MARK: - Posts List
                ScrollView {
                    LazyVStack(spacing: 0) {
                        ForEach(viewModel.posts) { post in
                            VStack(spacing: 0) {
                                PostCellView(post: post)
                                    .onAppear {
                                        viewModel.loadMorePostsIfNeeded(currentItem: post)
                                    }
                                
                                Divider()
                                    .background(AppColor.grey200.opacity(0.3))
                            }
                        }
                        
                        if viewModel.isLoading {
                            ProgressView()
                                .padding(.top, 16)
                        }
                    }
                    .padding(.top)
                }
                .background(Color.white)
            }
            //            .edgesIgnoringSafeArea(.top)
            .navigationBarHidden(true)
            .onAppear {
                viewModel.loadInitialPosts()
            }
        }
    }
}


