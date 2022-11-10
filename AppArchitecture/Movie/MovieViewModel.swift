//
//  MovieViewModel.swift
//  AppArchitecture
//
//  Created by Jean Ricardo Cesca on 09/11/22.
//

import Foundation

class MovieViewModel {
    
    var movies: Variable<[Movie]> = Variable([])
    
    let service: MoviesServicing

    init(service: MoviesServicing) {
        self.service = service
    }
    
    func fetchData() {
        service.getMovies { [weak self] result in
            switch result {
            case .success(let response):
                    self?.movies.value = response.results
            case .failure(_): break
            }
        }
    }
}
