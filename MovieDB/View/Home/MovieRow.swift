//
//  MovieRow.swift
//  MovieDB
//
//  Created by Lingga Kusuma Sakti on 22/01/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct MovieRow: View {
    var movie: Movie
    @ObservedObject var viewModel: MovieViewModel
    
    var body: some View {
        ZStack(alignment: .bottom) {
            movieView
            backgroundTitle
            title
        }
        .cornerRadius(16)
        .padding(.bottom, 4)
    }
}

extension MovieRow {
    var movieView: some View {
        WebImage(url: movie.backdropURL)
            .resizable()
            .indicator(.activity)
            .transition(.fade(duration: 0.5))
            .cornerRadius(16)
            .frame(height: 200)
    }
    
    var backgroundTitle: some View {
        Rectangle()
            .fill(Color.white.opacity(0.5))
            .frame(height: 30, alignment: .bottom)
    }
    
    var title: some View {
        Text(movie.title)
            .font(.title2)
            .fontWeight(.bold)
            .lineLimit(1)
            
    }
    
}
