//
//  AppConstants.swift
//  Prometheus
//
//  Created by Tim Pyshnov on 23/10/2019.
//  Copyright © 2019 Draewil. All rights reserved.
//

import UIKit

enum AppConstants {}

extension AppConstants {
    
    enum Strings {
        static let appName = "Prometheus"
    }
    
    enum Colors {
        static let navigationBarBackgroundColor = UIColor.hex("#182938")
        static let navigationBarTextColor = UIColor.white
        
        static let lightBlueColor = UIColor.hex("#17C9FE")
        static let highlightedBlueColor = UIColor.hex("#07B9EE")
        
        static let orangeColor = UIColor.hex("FDC035")
        static let darkerOrangeColor = UIColor.hex("FA8A29")
        static let blueColor = UIColor.hex("35CAF8")
        static let darkerBlueColor = UIColor.hex("289FF4")
    }
    
    enum Images {
        static let pin = UIImage(named: "pin")
        static let pinShadow = UIImage(named: "pin_shadow")
        static let emptyBox = UIImage(named: "empty_box")
        static let chevronLeft = UIImage(named: "chevron_left")
    }
    
}

