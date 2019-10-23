//
//  LocationOverviewCellModel.swift
//  Prometheus
//
//  Created by Tim Pyshnov on 23/10/2019.
//  Copyright © 2019 Draewil. All rights reserved.
//

import Foundation

struct LocationOverviewCellModel {
    let title: String
    let coordinate: String
    let currentWeather: String?
    let summaryWeather: String?
    let temperature: String?
}

extension LocationOverviewCellModel {
    
    init(with location: Location) {
        title = location.timezone
        coordinate = location.coordinateString
        currentWeather = location.currentWeather.summary
        summaryWeather = location.minutelyWeatherHistory?.summary
        temperature = location.currentWeather.temperatureString
    }
    
}
