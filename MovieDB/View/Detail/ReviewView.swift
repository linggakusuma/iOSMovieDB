//
//  ReviewView.swift
//  MovieDB
//
//  Created by Lingga Kusuma Sakti on 25/01/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct ReviewView: View {
    var review: Review
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            HStack {
                avatar
                author
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            content
        }
        .padding()
    }
}

extension ReviewView {
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
    }
}
