//
//  AppCoordinator.swift
//  Prometheus
//
//  Created by Tim Pyshnov on 22/10/2019.
//  Copyright © 2019 Draewil. All rights reserved.
//

import UIKit

final class AppCoordinator: Coordinator {
    
    let window: UIWindow
    let dependencyContainer: DependencyContainer
    
    private(set) var feedCoordinator: FeedCoordinator?
    
    init(window: UIWindow) {
        self.window = window
        
        let networkService = NetworkService()
        let api = Api(networkService: networkService)
        let locationsStore = LocationsStore(api: api)
        self.dependencyContainer = DependencyContainer(api: api, locationsStore: locationsStore)
        
        super.init()
    }
    
    // MARK: - Coordinator
    
    override func start() {
        let containerViewController = PrometheusContainerViewController()
        startFeedCoordinator()
        containerViewController.rootViewController = feedCoordinator?.navigationController
        
        window.rootViewController = containerViewController
        window.makeKeyAndVisible()
    }
    
    // MARK: - Child Coordinators
    
    private func startFeedCoordinator() {
        let navigationController = UINavigationController()
        feedCoordinator = FeedCoordinator(dependencyContainer: dependencyContainer, navigationController: navigationController)
        feedCoordinator!.start()
        addCoordinator(feedCoordinator!)
    }
    
}
