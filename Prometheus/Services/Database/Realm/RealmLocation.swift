//
//  RealmLocation.swift
//  Prometheus
//
//  Created by Tim Pyshnov on 24/10/2019.
//  Copyright © 2019 Draewil. All rights reserved.
//

import Foundation
import RealmSwift
import CoreLocation

class RealmLocation: Object {
    @objc dynamic var latitude: Double = 0.0
    @objc dynamic var longitude: Double = 0.0
    @objc dynamic var timezone: String = ""
    @objc dynamic var currentWeather: RealmWeather?
    @objc dynamic var minutelyWeatherHistory: RealmWeatherHistory?
    @objc dynamic var hourlyWeatherHistory: RealmWeatherHistory?
    @objc dynamic var dailyWeatherHistory: RealmWeatherHistory?
}

extension RealmLocation {
    
    convenience init(with location: Location) {
        self.init()
        self.latitude = location.coordinate.latitude
        self.longitude = location.coordinate.longitude
        self.timezone = location.timezone
        self.currentWeather = RealmWeather(with: location.currentWeather)
        
        if let minutelyWeatherHistory = location.minutelyWeatherHistory {
            self.minutelyWeatherHistory = RealmWeatherHistory(with: minutelyWeatherHistory)
        }
        
        if let hourlyWeatherHistory = location.hourlyWeatherHistory {
            self.hourlyWeatherHistory = RealmWeatherHistory(with: hourlyWeatherHistory)
        }
        
        if let dailyWeatherHistory = location.dailyWeatherHistory {
            self.dailyWeatherHistory = RealmWeatherHistory(with: dailyWeatherHistory)
        }
    }
    
}

extension Location {
    
    init(with realmLocation: RealmLocation) {
        self.coordinate = CLLocationCoordinate2D(latitude: realmLocation.latitude, longitude: realmLocation.longitude)
        self.timezone = realmLocation.timezone
        
        // realm says all objects must be optionals, so i must force-wrap here
        self.currentWeather = Weather(with: realmLocation.currentWeather!)
        
        if let minutelyWeatherHistory = realmLocation.minutelyWeatherHistory {
            self.minutelyWeatherHistory = WeatherHistory(with: minutelyWeatherHistory)
        } else {
            self.minutelyWeatherHistory = nil
        }

        if let hourlyWeatherHistory = realmLocation.hourlyWeatherHistory {
            self.hourlyWeatherHistory = WeatherHistory(with: hourlyWeatherHistory)
        } else {
            self.hourlyWeatherHistory = nil
        }
        
        if let dailyWeatherHistory = realmLocation.dailyWeatherHistory {
            self.dailyWeatherHistory = WeatherHistory(with: dailyWeatherHistory)
        } else {
            self.dailyWeatherHistory = nil
        }
    }
    
}

class RealmLocationsList: Object {
    let data = List<RealmLocation>()
}

extension RealmLocationsList {
    
    convenience init(with locations: [Location]) {
        self.init()
        self.data.append(objectsIn: locations.map { RealmLocation(with: $0) })
    }
    
}
