//
//  WeatherHistory.swift
//  Prometheus
//
//  Created by Tim Pyshnov on 22/10/2019.
//  Copyright © 2019 Draewil. All rights reserved.
//

import Foundation

struct WeatherHistory {
    let summary: String
    let data: [Weather]
}

extension WeatherHistory: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case summary
        case data
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        summary = try container.decode(String.self, forKey: .summary)
        data = try container.decode([Weather].self, forKey: .data)
    }
    
}
