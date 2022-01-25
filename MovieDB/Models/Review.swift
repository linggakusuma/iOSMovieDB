//
//  Review.swift
//  MovieDB
//
//  Created by Lingga Kusuma Sakti on 24/01/22.
//

import Foundation

struct ReviewResponse: Decodable {
    private enum CodingKeys: String, CodingKey {
        case results = "results"
        case totalPages = "total_pages"
    }
    let results: [Review]?
    let totalPages: Int?
}

struct Review: Decodable, Identifiable {
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case author = "author"
        case authorDetails = "author_details"
        case content = "content"
    }
    
    let id: String?
    let author: String?
    let authorDetails: AuthorDetails?
    let content: String?
}

struct AuthorDetails: Decodable {
    private enum CodingKeys: String, CodingKey {
        case avatar = "avatar_path"
    }
    var avatar: String?
    
    var avatarURL: URL? {
        if avatar?.contains("http") == true {
            return URL(string: String(avatar?.dropFirst() ?? ""))
        } else {
            return URL(string: "https://image.tmdb.org/t/p/w154\(avatar ?? "")")
        }
    }
}


