//
//  MovieDetailViewModel.swift
//  MovieDB
//
//  Created by Lingga Kusuma Sakti on 23/01/22.
//

import Foundation
import Combine

class MovieDetailViewModel: ObservableObject {
    
    private let movieService: MovieService
    private var cancellables: Set<AnyCancellable> = []
    
    @Published var movie: Movie?
    @Published var reviews: [Review] = []
    @Published var videos: [Video] = []
    @Published var errorMessage: String = ""
    @Published var isError: Bool = false
    @Published var isLoading: Bool = false
    @Published var isEmpty: Bool = false
    
    var page = 1
    
    init(movieService: MovieService = MovieService.shared) {
        self.movieService = movieService
    }
    
    func getMovieDetail(id: Int) {
        isLoading = true
        movieService.fetchDetailMovie(id: id)
            .receive(on: RunLoop.main)
            .sink(
                receiveCompletion: { completion in
                    switch completion {
                    case .failure(let error):
                        self.isError = true
                        self.errorMessage = error.localizedDescription
                        
                    case .finished:
                        self.isLoading = false
                    }
                },
                receiveValue: { movie in
                    self.movie = movie
                })
            .store(in: &cancellables)
    }
    
    func getReviews(id: Int) {
        movieService.fetchReviews(id: id, page: page)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    self.isError = true
                    self.errorMessage = error.localizedDescription
                    
                case .finished:
                    break
                }
            }, receiveValue: { review in
                if review.results?.isEmpty ?? false {
                    self.isEmpty = true
                    self.errorMessage = "No Review"
                } else {
                    self.reviews = review.results ?? []
                }
            })
            .store(in: &cancellables)
    }
    
    func getVideos(id: Int) {
        movieService.fetchVideos(id: id)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    self.isError = true
                    self.errorMessage = error.localizedDescription
                    print("ERROR VIDEO")
                    
                case .finished:
                    break
                }
                
            }, receiveValue: { videos in
                videos.forEach { video in
                    if video.type == "Trailer" {
                        self.videos.append(video)
                    }
                }
            })
            .store(in: &cancellables)
    }
}
