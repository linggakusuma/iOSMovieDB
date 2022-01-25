//
//  ReviewDetailViewModel.swift
//  MovieDB
//
//  Created by Lingga Kusuma Sakti on 25/01/22.
//

import Foundation
import Combine

class AllReviewViewModel: ObservableObject {
    
    private let movieService: MovieService
    private var cancellables: Set<AnyCancellable> = []
    
    @Published var reviews: [Review] = []
    @Published var errorMessage: String = ""
    @Published var isError: Bool = false
    @Published var isLoading: Bool = false
    @Published var isEmpty: Bool = false
    @Published var totalPages: Int = 0
    
    var page = 1
    
    init(movieService: MovieService = MovieService.shared) {
        self.movieService = movieService
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
                    self.reviews.append(contentsOf: review.results ?? [])
                    self.totalPages = review.totalPages ?? 0
                }
            })
            .store(in: &cancellables)
    }
    
    func loadMoreReviews(review:Review, id: Int) {
        let theresholdIndex = self.reviews.index(self.reviews.endIndex, offsetBy: -1)
        
        if reviews.firstIndex(where: { $0.id == review.id}) == theresholdIndex && (page + 1) <= self.totalPages  {
            page += 1
            getReviews(id: id)
            print("GET NEW PAGE")
        }
    }

}
