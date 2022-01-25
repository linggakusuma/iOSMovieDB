//
//  Movie.swift
//  MovieDB
//
//  Created by Lingga Kusuma Sakti on 22/01/22.
//

import Foundation

struct MovieResponse: Decodable {
    let results: [Movie]
}

struct Movie: Decodable, Identifiable {
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case backdrop = "backdrop_path"
        case overview = "overview"
        case poster = "poster_path"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
    }
    
    let id: Int
    let title: String
    let backdrop: String?
    let overview: String
    let poster: String
    let releaseDate: String
    let voteAverage: Double
    
    var backdropURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(backdrop ?? "")")!
    }
    
    var posterURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w154\(poster)")!
    }
}
