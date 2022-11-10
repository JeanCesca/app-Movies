//
//  AppArchitectureTests.swift
//  AppArchitectureTests
//
//  Created by Jean Ricardo Cesca on 10/11/22.
//

import XCTest
@testable import AppArchitecture

final class AppArchitectureTests: XCTestCase {
    
    static let movie = Movie(
        id: 436270,
        title: "Black Adam",
        overview: "Nearly 5,000 years after he was bestowed with the almighty powers of the Egyptian gods—and imprisoned just as quickly—Black Adam is freed from his earthly tomb, ready to unleash his unique form of justice on the modern world.",
        posterPath: "/3zXceNTtyj5FLjwQXuPvLYK5YYL.jpg")

    func test_DependencyInjection() {
        
        let moviesVC = ViewControllerProvider.getMovieViewController()
        XCTAssertNotNil(moviesVC.viewModel)
            
        let movieDetailsVC = ViewControllerProvider.getDetailViewController(for: Self.movie)
        XCTAssertNotNil(movieDetailsVC.viewModel)
        
        switch appConfiguration {
        case .live:
            XCTAssert(moviesVC.viewModel.service is MoviesService)
        case .mock:
            XCTAssert(moviesVC.viewModel.service is MockMoviesService)
        }
    }
    
    func test_MoviesViewModel_NumberOfCalls_for_FetchData() {
        //given
        let mockService = MockMoviesService()
        let viewModel = MoviesViewModel(service: mockService)
        
        //when
        viewModel.fetchData()
        
        //then
        XCTAssertEqual(mockService.getMoviesCounter, 1) //chamando a função fetchData() apenas uma vez
        XCTAssertEqual(viewModel.movies.value.count, 3) //número de células na array Mock
    }
    
    func test_MovieDetailsViewModel__NumberOfCalls_for_FetchData() {
        //given
        let mockService = MockMovieDetailsService()
        let viewModel = MovieDetailsViewModel(movie: Self.movie, service: mockService)
        
        //when
        viewModel.fetchData()
        
        //then
        XCTAssertEqual(mockService.getPosterCallCounter, 1)
        XCTAssertEqual(mockService.getCreditsCallCounter, 1)
    }
}
