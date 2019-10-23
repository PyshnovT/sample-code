//
//  FeedCoordinator.swift
//  Prometheus
//
//  Created by Tim Pyshnov on 22/10/2019.
//  Copyright © 2019 Draewil. All rights reserved.
//

import UIKit

final class FeedCoordinator: Coordinator {
    
    enum Page {
        case feed
        case addLocation
    }
    
    let dependencyContainer: DependencyContainer
    let navigationController: UINavigationController
    
    init(dependencyContainer: DependencyContainer, navigationController: UINavigationController) {
        self.dependencyContainer = dependencyContainer
        self.navigationController = navigationController
        
        super.init()
    }
    
    // MARK: - Coordinator
    
    override func start() {
        navigationController.isNavigationBarHidden = true
        transition(to: .feed)
    }
    
    // MARK: - Navigation
    
    private var locationsFeedViewController: LocationsFeedViewController?
    private var addLocationViewController: AddLocationViewController?
    
    private var page: Page = .feed
    
    private func transition(to page: Page) {
        self.page = page
        
        switch page {
        case .feed:

            locationsFeedViewController = LocationsFeedViewController(locationsStore: dependencyContainer.locationsStore)
            locationsFeedViewController!.delegate = self
            
            navigationController.setViewControllers([locationsFeedViewController!], animated: true)
            
        case .addLocation:
            
            addLocationViewController = AddLocationViewController(locationsStore: dependencyContainer.locationsStore)
            addLocationViewController?.delegate = self
            
            navigationController.pushViewController(addLocationViewController!, animated: true)
            
        }
    }
    
    private func pop() {
        switch page {
        case .addLocation:
            page = .feed
        default: break
        }
        
        navigationController.popViewController(animated: true)
    }
    
}

extension FeedCoordinator: LocationsFeedViewControllerDelegate {
    
    func locationsFeedViewControllerDidTapAddLocation(_ locationsFeedViewController: LocationsFeedViewController) {
        transition(to: .addLocation)
    }
    
}

extension FeedCoordinator: AddLocationViewControllerDelegate {
    
    func addLocationViewControllerDidPressBack(addLocationViewController: AddLocationViewController) {
        pop()
    }
    
    func addLocationViewControllerDidConfirmLocation(addLocationViewController: AddLocationViewController) {
        pop()
    }
    
}
