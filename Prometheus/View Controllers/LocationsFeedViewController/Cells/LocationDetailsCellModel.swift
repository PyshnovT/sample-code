//
//  LocationDetailsCellModel.swift
//  Prometheus
//
//  Created by Tim Pyshnov on 24/10/2019.
//  Copyright © 2019 Draewil. All rights reserved.
//

import UIKit

struct LocationDetailsCellModel {
    let items: [DetailItem]
}

extension LocationDetailsCellModel {
    
    enum DetailItem {
        case plain(PlainDetails)
        case windSpeed(WindSpeedDetails)
    }
    
    struct PlainDetails {
        let gradientColors: [UIColor]
        let title: String
        let subtitle: String
    }
    
    struct WindSpeedDetails {
        let gradientColors: [UIColor]
        let title: String
        let subtitle: String
        let windBearing: WindBearing?
    }
    
}

extension LocationDetailsCellModel {
    
    init(with location: Location) {
        var items: [DetailItem] = []
        
        if let humidity = location.currentWeather.humidity {
            let humidityDetails = PlainDetails(
                gradientColors: [AppConstants.Colors.blueColor, AppConstants.Colors.darkerBlueColor],
                title: "Humidity",
                subtitle: "\(humidity)")
            
            items.append(.plain(humidityDetails))
        }
        
        if let windSpeed = location.currentWeather.windSpeed {
            let windSpeedDetails = WindSpeedDetails(
                gradientColors: [AppConstants.Colors.orangeColor, AppConstants.Colors.darkerOrangeColor],
                title: "Wind Speed",
                subtitle: "\(windSpeed)",
                windBearing: location.currentWeather.windBearing)
            
            items.append(.windSpeed(windSpeedDetails))
        }
        
        self.items = items
    }
    
}

