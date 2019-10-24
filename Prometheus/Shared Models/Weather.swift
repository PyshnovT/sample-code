//
//  Weather.swift
//  Prometheus
//
//  Created by Tim Pyshnov on 22/10/2019.
//  Copyright © 2019 Draewil. All rights reserved.
//

import UIKit

struct Weather {
    let timestamp: Date
    let summary: String?
    let temperature: CGFloat?
    let humidity: CGFloat?
    let windSpeed: CGFloat?
    let windBearing: WindBearing?
    var units: Units?
    
    mutating func setUnits(_ units: Units) {
        self.units = units
    }
}

extension Weather: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case time
        case summary
        case temperature
        case humidity
        case windSpeed
        case windBearing
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let time = try container.decode(TimeInterval.self, forKey: .time)
        timestamp = Date(timeIntervalSince1970: time)
        
        summary = try? container.decode(String.self, forKey: .summary)
        temperature = try? container.decode(CGFloat.self, forKey: .temperature)
        humidity = try? container.decode(CGFloat.self, forKey: .humidity)
        windSpeed = try? container.decode(CGFloat.self, forKey: .windSpeed)

        if let windBearingDegrees = try? container.decode(Int.self, forKey: .windBearing) {
            let degrees = Measurement(value: Double(windBearingDegrees), unit: UnitAngle.degrees)
            windBearing = WindBearing(degrees: degrees)
        } else {
            windBearing = nil
        }
    }
    
}

extension Weather {
    
    var temperatureString: String? {
        if let temp = temperature {
            let rounded = round(temp * 10) / 10
            return String(describing: rounded) + (units?.temperatureSign ?? "")
        }
            
        return nil
    }
    
}
