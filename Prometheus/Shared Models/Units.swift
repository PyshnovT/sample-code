//
//  Units.swift
//  Prometheus
//
//  Created by Tim Pyshnov on 24/10/2019.
//  Copyright © 2019 Draewil. All rights reserved.
//

import Foundation

enum Units: String {
    case si
    case us
    
    init(with locale: Locale) {
        if let code = locale.regionCode?.lowercased(), code == Units.us.rawValue {
            self = .us
        } else {
            self = .si
        }
    }
}

extension Units {
    
    var temperatureSign: String {
        switch self {
        case .si: return "°C"
        case .us: return "°F"
        }
    }
    
}
