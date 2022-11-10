//
//  MockMovieDetailsService.swift
//  AppArchitecture
//
//  Created by Jean Ricardo Cesca on 10/11/22.
//

import Foundation
import UIKit

class MockMovieDetailsService: MovieDetailsServicing {
    
    func getPoster(for movie: Movie, _ completion: @escaping (Result<UIImage?, Error>) -> Void) {
        let mockPoster = UIImage(named: "art_mock")
        completion(.success(mockPoster))
    }
    
    func getCredits(for movie: Movie, _ completion: @escaping (Result<MovieCreditsResponse, Error>) -> Void) {
        let response = MovieCreditsResponse(cast: [
            MovieCastMember(id: 19492, name: "Viola Davis", character: "Nanisca"),
            MovieCastMember(id: 2286339, name: "Thuso Mbedu", character: "Nawi"),
            MovieCastMember(id: 1360281, name: "Lashana Lynch", character: "Izogie"),
        ])
        
        completion(.success(response))
    }
}
