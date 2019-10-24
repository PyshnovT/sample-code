//
//  Database.swift
//  Prometheus
//
//  Created by Tim Pyshnov on 24/10/2019.
//  Copyright © 2019 Draewil. All rights reserved.
//

import Foundation

// could be Realm or Core Data. We can switch up between them easily

protocol ReadableDatabase {
    func loadLocations() -> [Location]
}

protocol WritableDatabase {
    func saveLocations(_ locations: [Location])
}

typealias Database = ReadableDatabase & WritableDatabase
