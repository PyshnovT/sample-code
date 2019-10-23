//
//  Result.swift
//  Prometheus
//
//  Created by Tim Pyshnov on 22/10/2019.
//  Copyright © 2019 Draewil. All rights reserved.
//

import Foundation

enum Result<T> {
    case success(T)
    case error(Error)
}
