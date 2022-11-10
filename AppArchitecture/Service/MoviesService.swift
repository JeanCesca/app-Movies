//
//  APIManager.swift
//  AppArchitecture
//
//  Created by Jean Ricardo Cesca on 09/11/22.
//

import Foundation
import UIKit

protocol MoviesServicing: AnyObject {
    func getMovies(_ completion: @escaping (Result<MovieResponse, Error>) -> Void)
}

class MoviesService: MoviesServicing {
    
    let apiKey = "da9bc8815fb0fc31d5ef6b3da097a009"
    
    let jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()

    func getMovies(_ completion: @escaping (Result<MovieResponse, Error>) -> Void) {
        let url = URL(string: "https://api.themoviedb.org/3/movie/upcoming?api_key=\(apiKey)")!

        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(error!))
                return
            }
            
            do {
                let decoded = try self.jsonDecoder.decode(MovieResponse.self, from: data)
                completion(.success(decoded))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
