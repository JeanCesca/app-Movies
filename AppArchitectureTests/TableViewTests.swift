//
//  MoviesViewControllersTests.swift
//  AppArchitectureTests
//
//  Created by Jean Ricardo Cesca on 10/11/22.
//

import XCTest
@testable import AppArchitecture

final class TableViewTests: XCTestCase {
    
    private lazy var sut: MoviesViewController = {
        let sut = ViewControllerProvider.getMovieViewController()
        _ = sut.view
        return sut
    }()
    
    //set title to Upcoming Movies
    func test_viewDidLoad_setsTitle() {
        //when
        sut.loadViewIfNeeded()
        
        //then
        XCTAssertEqual(sut.title, "Upcoming Movies")
    }
    
    //se a tableview existe ao carregarmos a tela inicial
    func test_whenMoviesViewControllerLoads_tableViewShouldExist() {
        XCTAssertNotNil(sut.tableView)
    }
    
    //se o DataSource e Delegate são a mesma instância do MoviesViewController (self)
    func test_homeViewController_shouldBeTableViewDataSource() {
        sut.loadViewIfNeeded()
        
        XCTAssertNotNil(sut.tableView.delegate, "delegate")
        XCTAssertNotNil(sut.tableView.dataSource, "data source")
    }
    
    //verificar se num momento anterior ao retorno da API, quando ainda não há dados para exibir, a tableView não exibe nenhuma linha.
    func test_tableView_whenDataIsNil_numberOfSectionsShouldBeOne_numberOfRowsShouldBeZero() {
        let numberOfSections = sut.tableView.numberOfSections
        let numberOfRows = sut.tableView.numberOfRows(inSection: 0)
        
        XCTAssertEqual(numberOfSections, 1)
        XCTAssertEqual(numberOfRows, 0)
    }
    
//    agora verificando quando a API retorna dados:
    func test_tableView_whenViewModelReturnsData_numberOfSectionsShouldBeOne_numberOfRowsShouldMatchDataArraySize() {
        //given
        let service = MockMoviesService()
        let viewModel = MoviesViewModel(service: service)
        
        //when
        viewModel.fetchData()
        
        //then
        XCTAssertEqual(viewModel.movies.value[0].title, "Black Adam")
        XCTAssertEqual(viewModel.movies.value[0].id, 436270)
        XCTAssertEqual(viewModel.movies.value.count, 3)

    }

}
    
    
