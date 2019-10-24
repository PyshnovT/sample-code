//
//  RealmWeatherHistory.swift
//  Prometheus
//
//  Created by Tim Pyshnov on 24/10/2019.
//  Copyright © 2019 Draewil. All rights reserved.
//

import Foundation
import RealmSwift

class RealmWeatherHistory: Object {
    @objc dynamic var summary: String = ""
    let data = List<RealmWeather>()
}

extension RealmWeatherHistory {
    
    convenience init(with weatherHistory: WeatherHistory) {
        self.init()
        self.summary = weatherHistory.summary
        data.append(objectsIn: weatherHistory.data.map { RealmWeather(with: $0) })
    }
    
}

extension WeatherHistory {
    
    init(with realmWeatherHistory: RealmWeatherHistory) {
        self.summary = realmWeatherHistory.summary
        self.data = realmWeatherHistory.data.map { Weather(with: $0) }
    }
    
}
