//
//  Genre.swift
//  MovieDB
//
//  Created by Lingga Kusuma Sakti on 21/01/22.
//

import Foundation

struct GenreResponse: Decodable {
    let genres: [Genre]
}

struct Genre: Decodable, Identifiable {
    let id: Int
    let name: String
}
