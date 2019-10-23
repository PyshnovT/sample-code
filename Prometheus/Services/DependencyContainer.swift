//
//  DependencyContainer.swift
//  Prometheus
//
//  Created by Tim Pyshnov on 22/10/2019.
//  Copyright © 2019 Draewil. All rights reserved.
//

import Foundation

struct DependencyContainer {
    let api: Api
    let locationsStore: LocationsStore
    
    init(api: Api, locationsStore: LocationsStore) {
        self.api = api
        self.locationsStore = locationsStore
    }
}
