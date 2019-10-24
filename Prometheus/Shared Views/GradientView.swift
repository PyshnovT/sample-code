//
//  GradientView.swift
//  Prometheus
//
//  Created by Tim Pyshnov on 24/10/2019.
//  Copyright © 2019 Draewil. All rights reserved.
//

import UIKit

class GradientView: UIView {
    
    override open class var layerClass: AnyClass {
       return CAGradientLayer.classForCoder()
    }
    
    var gradientLayer: CAGradientLayer {
        return layer as! CAGradientLayer
    }

    var gradientColors: [UIColor] {
        get {
            let colors = gradientLayer.colors as! [CGColor]
            return colors.map { UIColor(cgColor: $0) }
        }
        set {
            gradientLayer.colors = newValue.map { $0.cgColor }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let gradientLayer = layer as! CAGradientLayer
        gradientLayer.colors = [UIColor.white.cgColor, UIColor.black.cgColor]
    }
    
}
