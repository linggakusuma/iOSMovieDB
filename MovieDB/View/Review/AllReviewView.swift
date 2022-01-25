//
//  AllReviewView.swift
//  MovieDB
//
//  Created by Lingga Kusuma Sakti on 25/01/22.
//

import SwiftUI

struct AllReviewView: View {
    var movieId: Int
    @ObservedObject var viewModel = AllReviewViewModel()
    var body: some View {
        List {
            VStack {
                if viewModel.isEmpty {
                    Text(viewModel.errorMessage)
                        .font(.body)
                        .fontWeight(.bold)
                } else if viewModel.isError {
                    Text(viewModel.errorMessage)
                        .font(.body)
                        .fontWeight(.bold)
                } else {
                    ForEach(self.viewModel.reviews) { review in
                        ReviewRow(isAllReview: true, review: review)
                            .listRowInsets(EdgeInsets())
                            .onAppear {
                                viewModel.loadMoreReviews(review: review, id: movieId)
                            }
                    }
                }
            }
        }
        .onAppear {
            viewModel.getReviews(id: movieId)
        }
    }
}
