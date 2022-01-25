//
//  ContentView.swift
//  MovieDB
//
//  Created by Lingga Kusuma Sakti on 21/01/22.
//

import SwiftUI

struct MovieView: View {
    @ObservedObject private var viewModel = MovieViewModel()
    
    init() {
        UITableViewCell.appearance().backgroundColor = .clear
        UITableView.appearance().backgroundColor = .clear
        UITableView.appearance().sectionIndexBackgroundColor = .clear
        UITableView.appearance().tableFooterView = UIView()
        UITableView.appearance().separatorStyle = .none
        UITableView.appearance().showsVerticalScrollIndicator = false
    }
    
    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isError {
                    error
                } else {
                    genreView
                    spacer
                    movieView
                }
            }.navigationBarTitle(Text("Movie"), displayMode: .inline)
                .onAppear {
                    self.viewModel.getGenres()
                }
            
        }
    }
}

extension MovieView {
    var loading: some View {
        VStack {
            Text("Loading...")
            ActivityIndicator()
        }
    }
    
    var error: some View {
        VStack {
            Text(self.viewModel.errorMessage)
                .font(.system(.body, design: .rounded))
        }
    }
    
    var spacer: some View {
        Spacer()
    }
    
    var genreView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(self.viewModel.genres) { genre in
                    GenreRow(genre: genre, viewModel: self.viewModel)
                }
            }
        }.padding(.horizontal, 8)
            .padding(.top, 4)
    }
    
    var movieView: some View {
        List {
            ForEach(self.viewModel.movies) { movie in
                if #available(iOS 15.0, *) {
                    ZStack {
                        MovieRow(movie: movie, viewModel: viewModel)
                        NavigationLink(destination: MovieDetailView(movieId: movie.id)) {
                            EmptyView()
                        }
                    }
                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 8, trailing: 0))
                    .listRowSeparator(.hidden)
                    .onAppear {
                        self.viewModel.loadMoreMovies(movie: movie)
                    }
                    .buttonStyle(PlainButtonStyle())
                } else {
                    // Fallback on earlier versions
                    ZStack {
                        MovieRow(movie: movie, viewModel: viewModel)
                        NavigationLink(destination: MovieDetailView(movieId: movie.id)) {
                            EmptyView()
                        }
                    }
                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 8, trailing: 0))
                    .onAppear {
                        self.viewModel.loadMoreMovies(movie: movie)
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                }
            }
        }.listStyle(InsetGroupedListStyle())
    }
}
