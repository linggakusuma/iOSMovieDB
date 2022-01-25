//
//  MovieViewModel.swift
//  MovieDB
//
//  Created by Lingga Kusuma Sakti on 21/01/22.
//

import Foundation
import Combine

class MovieViewModel: ObservableObject {
    
    private let movieService: MovieService
    private var cancellables: Set<AnyCancellable> = []
    
    @Published var genres: [Genre] = []
    @Published var movies: [Movie] = []
    @Published var genreSelected = 0
    
    @Published var errorMessage: String = ""
    @Published var isError: Bool = false
    
    var page = 1
    
    init(movieService: MovieService = MovieService.shared) {
        self.movieService = movieService
    }
    
    func getGenres(){
        movieService.fetchGenres()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    self.isError = true
                case .finished:
                    break
                }
            }, receiveValue: { genres in
                self.genres = genres
                self.genreSelected = genres[0].id
                self.getMovies(isChangeGenre: true, genre: self.genreSelected)
            })
            .store(in: &cancellables)
    }
    
    func getMovies(isChangeGenre: Bool, genre: Int) {
        self.genreSelected = genre
        if isChangeGenre {
            page = 1
        }
        movieService.fetchMovies(page: self.page, genre: "\(genre)")
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    self.isError = true
                    self.errorMessage = error.localizedDescription

                    
                case .finished:
                    break
                    
                }
            }, receiveValue: { movies in
                if isChangeGenre {
                    self.movies = movies
                } else {
                    self.movies.append(contentsOf: movies)
                }
            }).store(in: &cancellables)
        
    }
    
    func loadMoreMovies(movie:Movie) {
        let theresholdIndex = self.movies.index(self.movies.endIndex, offsetBy: -1)
        
        if movies.firstIndex(where: { $0.id == movie.id}) == theresholdIndex {
            page += 1
            getMovies(isChangeGenre: false, genre: self.genreSelected)
        }
        
    }
}
