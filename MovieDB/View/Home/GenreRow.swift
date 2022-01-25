//
//  GenreRow.swift
//  MovieDB
//
//  Created by Lingga Kusuma Sakti on 22/01/22.
//

import SwiftUI

struct GenreRow: View {
    var genre: Genre
    @ObservedObject var viewModel: MovieViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            genreView
        }
    }
}

extension GenreRow {
    var genreView: some View {
        Button(action: {
            self.viewModel.getMovies(isChangeGenre: true, genre: genre.id)
        }) {
            Text(genre.name)
                .bold()
                .foregroundColor(self.viewModel.genreSelected == genre.id ? .white : .black)
                .padding(8)
                .background(self.viewModel.genreSelected == genre.id ? Color.black : Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 16, style: .circular))
        }
    }
}
