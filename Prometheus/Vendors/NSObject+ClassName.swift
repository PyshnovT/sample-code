//
//  NSObject+ClassName.swift
//  Prometheus
//
//  Created by Tim Pyshnov on 23/10/2019.
//  Copyright © 2019 Draewil. All rights reserved.
//

import Foundation

extension NSObject {
    
    class var className: String {
        guard let result = String(describing: self).components(separatedBy: ".").last else {
            return String(describing: self)
        }
        
        return result
    }
    
    var className: String {
        return type(of: self).className
    }
    
}
