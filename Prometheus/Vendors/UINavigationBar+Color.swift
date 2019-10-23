//
//  UINavigationBar+Color.swift
//  Prometheus
//
//  Created by Tim Pyshnov on 23/10/2019.
//  Copyright © 2019 Draewil. All rights reserved.
//

import UIKit

extension UINavigationBar {

    func clear() {
        shadowImage = UIImage()
        setBackgroundImage(UIImage(), for: .default)
        isTranslucent = true
    }
    
    func fillShadowImage(color: UIColor) {
        let renderer = UIGraphicsImageRenderer(bounds: CGRect(side: 2))
        let image = renderer.image { (context) in
            let size = renderer.format.bounds.size
            color.setFill()
            context.fill(CGRect(size: size))
        }
        shadowImage = image
    }
    
    func fill(color: UIColor) {
        let renderer = UIGraphicsImageRenderer(bounds: CGRect(side: 1))
        let image = renderer.image { (context) in
            let size = renderer.format.bounds.size
            color.setFill()
            context.fill(CGRect(size: size))
        }
        shadowImage = image
        setBackgroundImage(image, for: .default)
        isTranslucent = false
    }
    
}
