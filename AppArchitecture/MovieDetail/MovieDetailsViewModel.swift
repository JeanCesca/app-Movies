//
//  MovieDetailsViewModel.swift
//  AppArchitecture
//
//  Created by Jean Ricardo Cesca on 09/11/22.
//

import Foundation
import UIKit

class MovieDetailsViewModel {
    
    let movie: Movie
    
    var poster: Variable<UIImage?> = Variable(nil)
    var cast: Variable<[MovieCastMember]> = Variable([])
    
    let service: MovieDetailsServicing
    
    init(movie: Movie, service: MovieDetailsServicing) {
        self.movie = movie
        self.service = service
    }
    
    func fetchData() {
        service.getPoster(for: movie) { [weak self] result in
            switch result {
            case .success(let poster):
                    self?.poster.value = poster
            case .failure(_): break
            }
        }
        
        service.getCredits(for: movie) { [weak self] result in
            switch result {
            case .success(let creditsResponse):
                    self?.cast.value = creditsResponse.cast
            case .failure(_): break
            }
        }
    }
}
