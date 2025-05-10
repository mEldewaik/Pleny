//
//  PostCellView.swift
//  PlenyApp
//
//  Created by Mohamed Eldewaik on 08/05/2025.
//

import SwiftUI

struct PostCellView: View {
    let post: Post
    var highlight: String? = nil
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // MARK: - User Info
            UserHeaderView(username: "Mohamed Eldewaik", timestamp: "2 days ago")
            
            // MARK: - Post Body with Optional Highlight
            Text(highlighted(post.body))
                .font(.body)
                .foregroundColor(.primary)
            
            // MARK: - Image Grid
            if !post.tags.isEmpty {
                ImageGridView(count: post.tags.count)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.05), radius: 3, x: 0, y: 2)
        .padding(.horizontal)
        .padding(.bottom, 16)
    }
    
    // MARK: - Highlight Logic
    private func highlighted(_ text: String) -> AttributedString {
        guard let keyword = highlight?.lowercased(),
              !keyword.isEmpty,
              var attributed = try? AttributedString(markdown: text)
        else {
            return AttributedString(text)
        }
        
        if let range = attributed.range(of: keyword, options: .caseInsensitive) {
            attributed[range].font = .body.bold()
        }
        
        return attributed
    }
}


