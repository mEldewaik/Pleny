//
//  ImageGridView.swift
//  PlenyApp
//
//  Created by Mohamed Eldewaik on 08/05/2025.
//

import SwiftUI

struct ImageGridView: View {
    let imageNames: [String]
    private let maxDisplayCount = 4
    private let spacing: CGFloat = 8
    private let totalHeight: CGFloat = 200
    
    init(count: Int) {
        self.imageNames = (0..<count).map { "post_image_\($0 % 6)" }
    }
    
    var body: some View {
        Group {
            switch imageNames.count {
            case 1:
                singleImageView(imageNames[0], height: totalHeight)
            case 2:
                HStack(spacing: spacing) {
                    ForEach(imageNames.prefix(2), id: \.self) {
                        singleImageView($0, height: totalHeight - (spacing * 2))
                    }
                }
            case 3:
                HStack(spacing: spacing) {
                    singleImageView(imageNames[0], height: totalHeight)
                    VStack(spacing: spacing) {
                        ForEach(imageNames[1...2], id: \.self) {
                            singleImageView($0, height: (totalHeight - spacing) / 2)
                        }
                    }
                }
            case 4:
                HStack(spacing: spacing) {
                    ForEach(0..<2) { col in
                        VStack(spacing: spacing) {
                            ForEach(0..<2) { row in
                                let index = col * 2 + row
                                singleImageView(imageNames[index], height: (totalHeight - spacing) / 2)
                            }
                        }
                    }
                }
            default:
                let displayImages = Array(imageNames.prefix(maxDisplayCount))
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: spacing) {
                    ForEach(displayImages.indices, id: \.self) { index in
                        ZStack {
                            singleImageView(displayImages[index], height: (totalHeight - spacing) / 2)
                            
                            if index == maxDisplayCount - 1 && imageNames.count > maxDisplayCount {
                                Color.black.opacity(0.4)
                                    .cornerRadius(12)
                                Text("+\(imageNames.count - maxDisplayCount)")
                                    .foregroundColor(.white)
                                    .font(.headline)
                            }
                        }
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .transition(.opacity)
    }
    
    private func singleImageView(_ name: String, height: CGFloat) -> some View {
        Image(name)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(height: height)
            .clipped()
            .cornerRadius(12)
    }
}

#Preview {
    VStack(spacing: 16) {
        ImageGridView(count: 1)
        ImageGridView(count: 2)
//        ImageGridView(count: 3)
//        ImageGridView(count: 4)
        ImageGridView(count: 6)
    }
    .padding()
}
