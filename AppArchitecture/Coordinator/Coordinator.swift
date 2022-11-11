//
//  Coordinator.swift
//  AppArchitecture
//
//  Created by Jean Ricardo Cesca on 11/11/22.
//

import Foundation
import UIKit

protocol Coordinator {
    
    var childCoordinators: [Coordinator] { get }
    var navigationController: UINavigationController { get }
    
    func startCoordinator()
}

class MainCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController = UINavigationController()
    
    func startCoordinator() {
        let vc = ViewControllerProvider.getMovieViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    
    func displayDetails(of movie: Movie) {
        let vc = ViewControllerProvider.getDetailViewController(for: movie)
        navigationController.pushViewController(vc, animated: true)
    }
    
    
}
