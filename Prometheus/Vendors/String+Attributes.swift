//
//  String+Attributes.swift
//  Prometheus
//
//  Created by Tim Pyshnov on 23/10/2019.
//  Copyright © 2019 Draewil. All rights reserved.
//

import UIKit

typealias Attributes = [NSAttributedString.Key: Any]

extension String {

    static func attributes(
        withFont font: UIFont,
        color: UIColor? = nil,
        lineSpacing: CGFloat? = nil,
        textAlignment: NSTextAlignment? = nil,
        kern: CGFloat? = nil
    ) -> [NSAttributedString.Key: Any] {
        let style = NSMutableParagraphStyle()
        style.lineSpacing = lineSpacing ?? 0
        style.alignment = textAlignment ?? .natural
        
        return [NSAttributedString.Key.font: font,
                NSAttributedString.Key.paragraphStyle: style,
                NSAttributedString.Key.foregroundColor: color ?? UIColor.black,
                NSAttributedString.Key.kern: kern ?? 0]
    }
    
    static func attributes(_ attributes: [NSAttributedString.Key: Any], font: UIFont? = nil, color: UIColor? = nil) -> [NSAttributedString.Key: Any] {
        var copy = attributes
        
        if let font = font {
            copy[NSAttributedString.Key.font] = font
        }
        
        if let color = color {
            copy[NSAttributedString.Key.foregroundColor] = color
        }
        
        return copy
    }
    
}

extension String {
    
    func withAttributes(_ attributes: [NSAttributedString.Key: Any]) -> NSAttributedString {
        return NSAttributedString(string: self, attributes: attributes)
    }
    
    func withAttributes(
        font: UIFont,
        color: UIColor? = nil,
        lineSpacing: CGFloat? = nil,
        textAlignment: NSTextAlignment? = nil,
        kern: CGFloat? = nil
    ) -> NSAttributedString {
        return NSAttributedString(string: self, attributes: String.attributes(withFont: font, color: color, lineSpacing: lineSpacing, textAlignment: textAlignment, kern: kern))
    }
    
    func size(
        for width: CGFloat,
        font: UIFont,
        lineSpacing: CGFloat? = nil,
        textAlignment: NSTextAlignment? = nil,
        kern: CGFloat? = nil
    ) -> CGSize {
        return NSAttributedString(string: self, attributes: String.attributes(withFont: font, lineSpacing: lineSpacing, textAlignment: textAlignment, kern: kern)).boundingSize(forWidth: width)
    }
    
}

