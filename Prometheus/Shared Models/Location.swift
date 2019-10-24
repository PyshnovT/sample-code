//
//  Location.swift
//  Prometheus
//
//  Created by Tim Pyshnov on 22/10/2019.
//  Copyright © 2019 Draewil. All rights reserved.
//

import Foundation
import CoreLocation

struct Location {
    let coordinate: CLLocationCoordinate2D
    let timezone: String
    var currentWeather: Weather
    let minutelyWeatherHistory: WeatherHistory?
    let hourlyWeatherHistory: WeatherHistory?
    let dailyWeatherHistory: WeatherHistory?
}

extension Location: Equatable {
    
    static func ==(lhs: Location, rhs: Location) -> Bool {
        return  lhs.coordinate.latitude == rhs.coordinate.latitude &&
                lhs.coordinate.longitude == rhs.coordinate.longitude
    }
    
}

extension Location: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case timezone
        case latitude
        case longitude
        case currently
        case minutely
        case hourly
        case daily
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let latitude = try container.decode(Double.self, forKey: .latitude)
        let longitude = try container.decode(Double.self, forKey: .longitude)
        coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        timezone = try container.decode(String.self, forKey: .timezone)
        currentWeather = try container.decode(Weather.self, forKey: .currently)
        minutelyWeatherHistory = try? container.decode(WeatherHistory.self, forKey: .minutely)
        hourlyWeatherHistory = try? container.decode(WeatherHistory.self, forKey: .hourly)
        dailyWeatherHistory = try? container.decode(WeatherHistory.self, forKey: .daily)
    }
    
}

extension Location {
    var coordinateString: String {
        return "\(coordinate.latitude),\(coordinate.longitude)"
    }
    
    var suggestedWeatherHistory: WeatherHistory? {
        if let minutelyWeatherHistory = minutelyWeatherHistory {
            return minutelyWeatherHistory
        } else if let hourlyWeatherHistory = hourlyWeatherHistory {
            return hourlyWeatherHistory
        } else if let dailyWeatherHistory = dailyWeatherHistory {
            return dailyWeatherHistory
        }
        
        return nil
    }
}
