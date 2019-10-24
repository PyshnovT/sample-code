//
//  RealmWeather.swift
//  Prometheus
//
//  Created by Tim Pyshnov on 24/10/2019.
//  Copyright © 2019 Draewil. All rights reserved.
//

import Foundation
import RealmSwift

class RealmWeather: Object {
    @objc dynamic var timestamp: Date = Date()
    @objc dynamic var summary: String?
    @objc dynamic var units: String?
    
    let temperature = RealmOptional<Double>()
    let humidity = RealmOptional<Double>()
    let windSpeed = RealmOptional<Double>()
    let windBearing = RealmOptional<Int>()
}

extension RealmWeather {
    
    convenience init(with weather: Weather) {
        self.init()
        self.timestamp = weather.timestamp
        self.summary = weather.summary
        self.units = weather.units?.rawValue
        
        if let temperature = weather.temperature {
            self.temperature.value = Double(temperature)
        }
        
        if let humidity = weather.humidity {
            self.humidity.value = Double(humidity)
        }
        
        if let windSpeed = weather.windSpeed {
            self.windSpeed.value = Double(windSpeed)
        }
        
        if let windBearing = weather.windBearing?.degrees.value {
            self.windBearing.value = Int(windBearing)
        }
    }
    
}

extension Weather {
    
    init(with realmWeather: RealmWeather) {
        self.timestamp = realmWeather.timestamp
        self.summary = realmWeather.summary
        self.units = (realmWeather.units != nil) ? Units(rawValue: realmWeather.units!) : nil
        self.temperature = (realmWeather.temperature.value != nil) ? CGFloat(realmWeather.temperature.value!) : nil
        self.humidity = (realmWeather.humidity.value != nil) ? CGFloat(realmWeather.humidity.value!) : nil
        self.windSpeed = (realmWeather.windSpeed.value != nil) ? CGFloat(realmWeather.windSpeed.value!) : nil
        
        if let windBearingDegrees = realmWeather.windBearing.value {
            let degrees = Measurement(value: Double(windBearingDegrees), unit: UnitAngle.degrees)
            windBearing = WindBearing(degrees: degrees)
        } else {
            windBearing = nil
        }
    }
}
