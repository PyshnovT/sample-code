//
//  Language.swift
//  Prometheus
//
//  Created by Tim Pyshnov on 24/10/2019.
//  Copyright © 2019 Draewil. All rights reserved.
//

import Foundation

enum Language: String {
    case english = "en"
    case french = "fr"
    case spanish = "es"
    case german = "de"
    
    init(with locale: Locale) {
        var code: String?
        
        if let preferredLanguage = Locale.preferredLanguages.first {
            code = preferredLanguage.prefix(2).lowercased()
        } else {
            code = locale.languageCode?.lowercased()
        }
        
        if let code = code, let lang = Language(rawValue: code) {
            self = lang
        } else {
            self = .english
        }
    }
}
