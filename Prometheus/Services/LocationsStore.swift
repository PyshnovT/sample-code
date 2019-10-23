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
    
    let api: Api
    
    var language: Language = .english
    var units: Units = .si
    
    private(set) var locations: [Location] = []
    
    // MARK: - Init
    
    init(api: Api) {
        self.api = api
    }
    
    // MARK: - Store
    
    func insertLocation(_ location: Location) {
        self.locations.insert(location, at: 0)
    }
    
    func addLocations(_ locations: [Location]) {
        self.locations.append(contentsOf: locations)
    }
    
    // MARK: - Api
    
    func fetchLocation(coordinate: CLLocationCoordinate2D, completion: @escaping Api.ApiWeatherCompletion) {
        
        let x: Double = 100000
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
    
}

// MARK: - Data Types

extension LocationsStore {

    enum Language: String {
        case english = "en"
        case french = "fr"
        case spanish = "es"
        case german = "de"
    }
    
    enum Units: String {
        case si
        case us
    }
    
}
