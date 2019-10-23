//
//  Coordinator.swift
//  Prometheus
//
//  Created by Tim Pyshnov on 22/10/2019.
//  Copyright © 2019 Draewil. All rights reserved.
//

import UIKit

class Coordinator: NSObject {

    private(set) var childCoordinators: [Coordinator] = []
    
    // MARK: - Content
    
    // for overriding
    func start() {}
    
    func addCoordinator(_ coordinator: Coordinator) {
        childCoordinators.append(coordinator)
    }
    
    func removeCoordinator(_ coordinator: Coordinator) {
        let index = childCoordinators.firstIndex { $0 == coordinator }
        
        if let index = index {
            childCoordinators.remove(at: index)
        }
    }
    
}

