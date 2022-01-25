//
//  MovieService.swift
//  MovieDB
//
//  Created by Lingga Kusuma Sakti on 21/01/22.
//

import Foundation
import Combine
import Alamofire

protocol MovieServiceProtocol {
    func fetchGenres() -> AnyPublisher<[Genre], Error>
    func fetchMovies(page: Int, genre: String) -> AnyPublisher<[Movie], Error>
    func fetchDetailMovie(id: Int) -> AnyPublisher<Movie, Error>
    func fetchReviews(id: Int, page: Int) -> AnyPublisher<ReviewResponse, Error>
    func fetchVideos(id: Int) -> AnyPublisher<[Video], Error>
}

class MovieService: MovieServiceProtocol {
    static let shared = MovieService()
    
    func fetchGenres() -> AnyPublisher<[Genre], Error> {
        return Future<[Genre], Error> { completion in
            if let url = URL(string: Endpoints.Gets.genres.url) {
                AF.request(url)
                    .validate()
                    .responseDecodable(of: GenreResponse.self) { response in
                        switch response.result {
                        case .success(let value):
                            completion(.success(value.genres))
                        case .failure:
                            completion(.failure(URLError.invalidEmptyResponse))
                        }
                    }
            }
        }.eraseToAnyPublisher()
    }
    
    func fetchMovies(page: Int, genre: String) -> AnyPublisher<[Movie], Error> {
        return Future<[Movie], Error> { completion in
            if let url = URL(string: Endpoints.Gets.movies(page: page, genre: genre).url) {
                AF.request(url)
                    .validate()
                    .responseDecodable(of: MovieResponse.self) { response in
                        switch response.result {
                        case .success(let value):
                            completion(.success(value.results))
                        case .failure:
                            completion(.failure(URLError.invalidEmptyResponse))
                        }
                    }
            }
        }.eraseToAnyPublisher()
    }
    
    func fetchDetailMovie(id: Int) -> AnyPublisher<Movie, Error> {
        return Future<Movie, Error> { completion in
            if let url = URL(string: Endpoints.Gets.detailMovie(id: id).url) {
                AF.request(url)
                    .validate()
                    .responseDecodable(of: Movie.self) { response in
                        switch response.result {
                        case .success(let value):
                            completion(.success(value))
                        case .failure:
                            completion(.failure(URLError.invalidEmptyResponse))
                        }
                    }
            }
        }.eraseToAnyPublisher()
    }
    
    func fetchReviews(id: Int, page: Int) -> AnyPublisher<ReviewResponse, Error> {
        return Future<ReviewResponse, Error> { completion in
            if let url = URL(string: Endpoints.Gets.review(id: id, page: page).url) {
                AF.request(url)
                    .validate()
                    .responseDecodable(of: ReviewResponse.self) { response in
                        switch response.result {
                        case .success(let value):
                            completion(.success(value))
                        case .failure:
                            completion(.failure(URLError.invalidEmptyResponse))
                        }
                    }
            }
        }.eraseToAnyPublisher()
    }
    
    func fetchVideos(id: Int) -> AnyPublisher<[Video], Error> {
        return Future<[Video], Error> { completion in
            if let url = URL(string: Endpoints.Gets.videos(id: id).url) {
                AF.request(url)
                    .validate()
                    .responseDecodable(of: VideoResponse.self) { response in
                        switch response.result {
                        case .success(let value):
                            completion(.success(value.results))
                        case .failure:
                            completion(.failure(URLError.invalidEmptyResponse))
                        }
                    }
            }
        }.eraseToAnyPublisher()
    }
}
