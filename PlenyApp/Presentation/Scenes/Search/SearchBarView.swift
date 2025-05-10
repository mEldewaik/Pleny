//
//  SearchBarView.swift
//  PlenyApp
//
//  Created by Mohamed Eldewaik on 10/05/2025.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var text: String
    let onCancel: () -> Void

    var body: some View {
        HStack(spacing: 12) {
            // MARK: - Search Field Area
            HStack(spacing: 8) {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(AppColor.grey700)

                TextField("Search...", text: $text)
                    .foregroundColor(.primary)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)

                if !text.isEmpty {
                    Button(action: {
                        text = ""
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                            .imageScale(.medium)
                    }
                }
            }
            .padding(.horizontal, 12)
            .frame(height: 40)
            .background(Color.white)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
            )
            .cornerRadius(12)

            // MARK: - External Cancel Icon Button
            Button(action: onCancel) {
                Image("close-circle")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .padding(8)
            }
        }
        .padding(.horizontal)
        .padding(.top, 12)
    }
}



