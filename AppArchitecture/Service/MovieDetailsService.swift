//
//  MovieDetailsService.swift
//  AppArchitecture
//
//  Created by Jean Ricardo Cesca on 10/11/22.
//

import Foundation
import UIKit

protocol MovieDetailsServicing: AnyObject {
    func getPoster(for movie: Movie, _ completion: @escaping (Result<UIImage?, Error>) -> Void)
    func getCredits(for movie: Movie, _ completion: @escaping (Result<MovieCreditsResponse, Error>) -> Void)
}

class MovieDetailsService: MovieDetailsServicing {
    
    let apiKey = "da9bc8815fb0fc31d5ef6b3da097a009"
    
    let jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    func getPoster(for movie: Movie, _ completion: @escaping (Result<UIImage?, Error>) -> Void) {
        URLSession.shared.dataTask(with: movie.posterURL) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(error!))
                return
            }

            let decoded = UIImage(data: data)
            completion(.success(decoded))
            
        }.resume()
    }
    
    func getCredits(for movie: Movie, _ completion: @escaping (Result<MovieCreditsResponse, Error>) -> Void) {
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(movie.id)/credits?api_key=\(apiKey)")!
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(error!))
                return
            }
            
            do {
                let decoded = try self.jsonDecoder.decode(MovieCreditsResponse.self, from: data)
                completion(.success(decoded))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
}
