//
//  UserHeaderView.swift
//  PlenyApp
//
//  Created by Mohamed Eldewaik on 08/05/2025.
//

import SwiftUI

struct UserHeaderView: View {
    let username: String
    let timestamp: String

    var body: some View {
        HStack(spacing: 12) {
            Image("profile_placeholder")
                .resizable()
                .frame(width: 40, height: 40)
                .clipShape(Circle())

            VStack(alignment: .leading, spacing: 2) {
                Text(username)
                    .font(.headline)
                    .foregroundColor(AppColor.grey900)

                Text(timestamp)
                    .font(.footnote)
                    .foregroundColor(AppColor.grey600)
            }

            Spacer()

            Image(systemName: "ellipsis")
                .foregroundColor(AppColor.grey600)
        }
    }
}

#Preview {
    UserHeaderView(username: "Mohamed Eldewaik", timestamp: "2 days ago")
}


