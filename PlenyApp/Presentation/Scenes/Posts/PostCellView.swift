//
//  PostCellView.swift
//  PlenyApp
//
//  Created by Mohamed Eldewaik on 08/05/2025.
//

import SwiftUI

struct PostCellView: View {
    let post: Post

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            UserHeaderView(
                username: "Mohamed Eldewaik", // or use dummy data
                timestamp: "2 days ago"
            )

            Text(post.body)
                .font(.body)
                .foregroundColor(AppColor.grey700)

            ImageGridView(count: post.id)

        }
        .padding()
        .background(Color.white)
        .cornerRadius(16)
        .padding(.bottom, 8)
        .padding(.horizontal)
    }
}


