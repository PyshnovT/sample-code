//
//  DependencyContainer.swift
//  Prometheus
//
//  Created by Tim Pyshnov on 22/10/2019.
//  Copyright © 2019 Draewil. All rights reserved.
//

import Foundation
import RealmSwift

struct DependencyContainer {
    let api: Api
    let locationsStore: LocationsStore
    let realmAdapter: RealmAdapter?
    
    init(api: Api, locationsStore: LocationsStore, realmAdapter: RealmAdapter?) {
        self.api = api
        self.locationsStore = locationsStore
        self.realmAdapter = realmAdapter
    }
}
