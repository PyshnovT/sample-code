//
//  String+Sizing.swift
//  Prometheus
//
//  Created by Tim Pyshnov on 23/10/2019.
//  Copyright © 2019 Draewil. All rights reserved.
//

import UIKit

extension String {
    
    func boundingSize(withSize size: CGSize, attributes: [NSAttributedString.Key: Any]?) -> CGSize {
        let string = self as NSString
        
        let options: NSStringDrawingOptions = [.usesLineFragmentOrigin, .usesFontLeading]
        var rect = string.boundingRect(with: size, options: options, attributes: attributes, context: nil)
        rect = rect.integral
        
        return rect.size
    }
    
    func boundingSize(forWidth width: CGFloat, attributes: [NSAttributedString.Key: Any]?) -> CGSize {
        return boundingSize(withSize: CGSize(width: width, height: CGFloat.greatestFiniteMagnitude),
                            attributes: attributes)
    }
    
}

extension NSAttributedString {
    
    func boundingSize(withSize size: CGSize) -> CGSize {
        
        let options: NSStringDrawingOptions = [.usesLineFragmentOrigin, .usesFontLeading]
        var rect = boundingRect(with: size, options: options, context: nil)
        rect = rect.integral
        
        return rect.size
    }
    
    func boundingSize(forWidth width: CGFloat) -> CGSize {
        return boundingSize(withSize: CGSize(width: width, height: CGFloat.greatestFiniteMagnitude))
    }
    
}
