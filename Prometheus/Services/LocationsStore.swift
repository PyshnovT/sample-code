//
//  LocationsStore.swift
//  Prometheus
//
//  Created by Tim Pyshnov on 23/10/2019.
//  Copyright © 2019 Draewil. All rights reserved.
//

import Foundation
import CoreLocation

class LocationsStore {
    
    typealias LocationsStoreReplaceCompletion = (_ oldLocation: Location, _ newLocation: Location) -> Void
    
    let api: Api
    let database: Database?
    
    var language: Language = Language(with: Locale.current)
    var units: Units = Units(with: Locale.current)
    
    private(set) var locations: [Location] = []
    
    // MARK: - Init
    
    init(api: Api, database: Database?) {
        self.api = api
        self.database = database
    }
    
    // MARK: - Database
    
    func fetchAllLocations() {
        if let loadedLocations = database?.loadLocations() {
            locallyAddLocations(loadedLocations)
        }
    }
    
    // MARK: - Api
    
    func fetchLocation(coordinate: CLLocationCoordinate2D, completion: @escaping Api.ApiWeatherCompletion) {
        
        let x: Double = 1000000
        let latitude = Double(round(coordinate.latitude * x) / x)
        let longitude = Double(round(coordinate.longitude * x) / x)
        
        api.fetchLocation(
            latitude: "\(latitude)",
            longitude: "\(longitude)",
            lang: language.rawValue,
            units: units.rawValue,
            completion: completion
        )
        
    }
    
    func refreshAllLocations(singleReplacementCompletion: @escaping LocationsStoreReplaceCompletion) {
        
        for location in locations {
            
            fetchLocation(coordinate: location.coordinate) { [weak self] (result) in
                switch result {
                case .success(let newLocation):
                    self?.replaceLocation(location, with: newLocation)
                    singleReplacementCompletion(location, newLocation)
                default:
                    break
                }
            }
            
        }
        
    }
    
}

// MARK: - Store

extension LocationsStore {
    
    // MARK: Public

    func insertLocation(_ location: Location) {
        locallyRemoveCopies(of: location)
        locallyInsertLocation(location)
        database?.saveLocations(locations)
    }
    
    func replaceLocation(_ location: Location, with newLocation: Location) {
        locallyReplaceLocation(location, with: newLocation)
        database?.saveLocations(self.locations)
    }
    
    // MARK: Private
    
    private func locallyInsertLocation(_ location: Location) {
        locations.insert(location, at: 0)
    }
    
    private func locallyRemoveCopies(of location: Location) {
        locations.removeAll(where: { location == $0 })
    }
    
    private func locallyAddLocations(_ locations: [Location]) {
        self.locations.append(contentsOf: locations)
    }
    
    private func locallyReplaceLocation(_ location: Location, with newLocation: Location) {
        let index = locations.firstIndex { location == $0 }
        guard let foundIndex = index else { return }
        locations[foundIndex] = newLocation
    }
}
