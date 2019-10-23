//
//  LocationsFeedContentViewController+DataTypes.swift
//  Prometheus
//
//  Created by Tim Pyshnov on 22/10/2019.
//  Copyright © 2019 Draewil. All rights reserved.
//

import Foundation

// MARK: - Data Types

extension LocationsFeedContentViewController {
    
    struct Section {
        let items: [FeedItem]
    }
    
    enum FeedItem {
        case overview(Location)
        case details(Location)
    }
    
}

// MARK: - Location+Section

extension LocationsFeedContentViewController.Section {
    
    typealias FeedItem = LocationsFeedContentViewController.FeedItem
    
    init(with location: Location) {
        let overview = FeedItem.overview(location)
        let table = FeedItem.overview(location)
        
        self.items = [overview, table]
    }
    
}
