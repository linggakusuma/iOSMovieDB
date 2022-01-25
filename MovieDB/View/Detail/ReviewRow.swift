//
//  ReviewRow.swift
//  MovieDB
//
//  Created by Lingga Kusuma Sakti on 25/01/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct ReviewRow: View {
    @State private var isExpanded = false
    var isAllReview: Bool = false
    var review: Review
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                avatar
                author
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            content
            readMore
        }
        .padding()
        .frame(width: isAllReview ? .infinity : UIScreen.main.bounds.width - 32)
        .background(Color.gray.opacity(0.3))
        .cornerRadius(16)
    }
}

extension ReviewRow {
    
    var spacer: some View {
        Spacer()
    }
    
    var author: some View {
        Text(review.author ?? "")
            .font(.body)
            .fontWeight(.medium)
    }
    
    var avatar: some View {
        WebImage(url: review.authorDetails?.avatarURL)
            .resizable()
            .indicator(.activity)
            .transition(.fade(duration: 0.5))
            .scaledToFit()
            .clipShape(Circle())
            .frame(width: 50)
    }
    
    var content: some View {
        Text(review.content ?? "")
            .font(.body)
            .fontWeight(.light)
            .lineLimit(isAllReview ? nil : 7)
    }
    
    var readMore: some View {
        Button(action: {
            if !isAllReview {
                isExpanded.toggle()
            }
        }) {
            if !isAllReview {
                Text(isExpanded ? "" : "Read More")
                    .font(.body)
                    .fontWeight(.medium)
            }
        }
        .sheet(isPresented: $isExpanded) {
            ReviewView(review: review)
        }
        .frame(maxWidth: .infinity, alignment: .bottomTrailing)
    }
}
