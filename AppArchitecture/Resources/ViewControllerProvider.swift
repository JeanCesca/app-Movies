//
//  ViewControllerProvider.swift
//  AppArchitecture
//
//  Created by Jean Ricardo Cesca on 10/11/22.
//

import Foundation

enum AppConfiguration {
    case live
    case mock
}

#if MOCK
let appConfiguration: AppConfiguration = .mock
#else
let appConfiguration: AppConfiguration = .live
#endif

struct ViewControllerProvider {
    
    private init() {}
    
    static func getMovieViewController() -> MoviesViewController {
        
        let movieService: MoviesServicing
        
        switch appConfiguration {
        case .live:
            movieService = MoviesService()
        case .mock:
            movieService = MockMoviesService()
        }
        
        let viewModel = MovieViewModel(service: movieService)
        let vc = MoviesViewController(viewModel: viewModel)
        return vc
    }
    
    static func getDetailViewController(for movie: Movie) -> MovieDetailsViewController {
        
        let movieDetailsService: MovieDetailsServicing
        
        switch appConfiguration {
        case .live:
            movieDetailsService = MovieDetailsService()
        case .mock:
            movieDetailsService = MockMovieDetailsService()
        }
        
        let viewModel = MovieDetailsViewModel(movie: movie, service: movieDetailsService)
        let vc = MovieDetailsViewController(viewModel: viewModel)
        return vc
    }
    
}
