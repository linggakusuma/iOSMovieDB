//
//  MovieDetailView.swift
//  MovieDB
//
//  Created by Lingga Kusuma Sakti on 23/01/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct MovieDetailView: View {
    @ObservedObject var viewModel = MovieDetailViewModel()
    let movieId: Int
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            if viewModel.isLoading {
                loading
            } else if viewModel.isError{
                error
            } else {
                backdrop
                spacer
                VStack(alignment:.leading) {
                    title
                    spacer
                    overviewLabel
                    overview
                    reviewLabel
                    reviewView
                    videoLabel
                    videoView
                }
                .padding(.horizontal, 4)
                .padding(.bottom, 4)
                
            }
        }
        .onAppear{
            viewModel.getMovieDetail(id: self.movieId)
            viewModel.getReviews(id: self.movieId)
            viewModel.getVideos(id: self.movieId)
        }
        .navigationBarTitle(viewModel.movie?.title ?? "")
    }
}

extension MovieDetailView {
    
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
    
    var backdrop: some View {
        ZStack(alignment: .bottomLeading) {
            WebImage(url: self.viewModel.movie?.backdropURL)
                .resizable()
                .indicator(.activity)
                .transition(.fade(duration: 0.5))
                .scaledToFit()
            
            HStack {
                poster
                VStack(alignment: .leading) {
                    detailInformationLabel
                    releaseDate
                    ratingBar
                }
                
            }.alignmentGuide(.bottom) { d in
                d[.bottom] / 3
            }
        }
        
    }
    
    var poster: some View {
        WebImage(url: self.viewModel.movie?.posterURL)
            .indicator(.activity)
            .scaledToFit()
            .cornerRadius(16)
            .padding(.leading, 4)
            .transition(.fade(duration: 0.5))
    }
    
    var title: some View {
        Text(self.viewModel.movie?.title ?? "")
            .font(.title3)
            .fontWeight(.bold)
            .multilineTextAlignment(.leading)
        
    }
    
    var releaseDate: some View {
        Text(self.viewModel.movie?.releaseDate ?? "")
            .font(.body)
    }
    
    var ratingBar: some View {
        HStack(spacing: 0) {
            ForEach(0..<Int(self.viewModel.movie?.voteAverage ?? 0.0)/2) { _ in
                Image(systemName: "star.fill")
                    .resizable()
                    .frame(width: 15, height: 15)
            }
        }
    }
    
    var overviewLabel: some View {
        Text("Overview")
            .font(.body)
            .fontWeight(.bold)
        
    }
    
    var detailInformationLabel: some View {
        Text("Detail Information")
            .font(.body)
            .fontWeight(.bold)
    }
    
    var overview: some View {
        Text(self.viewModel.movie?.overview ?? "")
            .font(.body)
    }
    
    var reviewLabel: some View {
        HStack {
            Text("Reviews")
                .font(.body)
                .fontWeight(.bold)
                .padding(.top, 4)
            
            spacer
            seeAllReview
        }
    }
    
    var reviewView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                if viewModel.isEmpty {
                    Text(viewModel.errorMessage)
                        .font(.body)
                        .fontWeight(.bold)
                } else {
                    ForEach(self.viewModel.reviews) { review in
                        ReviewRow(isAllReview: false, review: review)
                    }
                }
            }
        }
        .padding(.top, 4)
    }
    
    var seeAllReview: some View {
        NavigationLink(destination: AllReviewView(movieId: movieId)) {
            Text("See All")
                .font(.body)
                .fontWeight(.bold)
                .padding(.top, 4)
        }
    }
    
    var videoLabel: some View {
        Text("Trailer")
            .font(.body)
            .fontWeight(.bold)
            .padding(.top, 4)
    }
    
    var videoView: some View {
        ScrollView(.vertical, showsIndicators: false) {
            ForEach(self.viewModel.videos) { video in
                VideoRow(video: video)
            }
        }
        .padding(.top, 4)
    }
}
