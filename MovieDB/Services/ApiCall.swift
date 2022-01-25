//
//  ApiCall.swift
//  MovieDB
//
//  Created by Lingga Kusuma Sakti on 21/01/22.
//

import Foundation

struct ApiCall {
    static let baseUrl = "https://api.themoviedb.org/3/"
    static let apiKey = "d12328fcec7d65af2acf79b488c7d59c"
}

protocol Endpoint {
    var url: String { get }
}

enum Endpoints {
    enum Gets: Endpoint {
        case genres
        case movies(page: Int, genre: String)
        case detailMovie(id: Int)
        case review(id: Int, page: Int)
        case videos(id: Int)
        
        public var url: String {
            switch self {
            case .genres:
                return "\(ApiCall.baseUrl)genre/movie/list?api_key=\(ApiCall.apiKey)"
                
            case .movies(let page, let genre):
                return "\(ApiCall.baseUrl)discover/movie?api_key=\(ApiCall.apiKey)&page=\(page)&with_genres=\(genre)"
                
            case .detailMovie(let id):
                return "\(ApiCall.baseUrl)movie/\(id)?api_key=\(ApiCall.apiKey)"
                
            case .review(let id, let page):
                return "\(ApiCall.baseUrl)movie/\(id)/reviews?api_key=\(ApiCall.apiKey)&page=\(page)"
                
            case .videos(id: let id):
                return "\(ApiCall.baseUrl)movie/\(id)/videos?api_key=\(ApiCall.apiKey)"
            }
        }
    }
}

enum URLError: LocalizedError {
    
case invalidEmptyResponse
case addressUnreachable(URL)
    
    var errorDescription: String? {
        switch self {
        case .invalidEmptyResponse: return "The server responded with garbage."
        case .addressUnreachable(let url): return "\(url.absoluteString) is unreachable"
        }
    }
}

