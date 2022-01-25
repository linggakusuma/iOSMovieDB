//
//  Video.swift
//  MovieDB
//
//  Created by Lingga Kusuma Sakti on 25/01/22.
//

import Foundation

struct VideoResponse: Decodable {
    let results: [Video]
}

struct Video: Decodable, Identifiable {
    let id: String
    let site: String
    let key: String
    let type: String
    let name: String
    
    var youtubeURL: URL? {
        guard site == "YouTube" else {
            return nil
        }
        return URL(string: "https://youtube.com/watch?v=\(key)")
    }
}
