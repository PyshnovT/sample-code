//
//  Utils.swift
//  Prometheus
//
//  Created by Tim Pyshnov on 23/10/2019.
//  Copyright © 2019 Draewil. All rights reserved.
//

import UIKit

extension CGRect {
    init(size: CGSize) {
        self.init(origin: CGPoint.zero, size: size)
    }
    
    init(side: CGFloat) {
        self.init(size: CGSize(width: side, height: side))
    }
    
    init(width: CGFloat, height: CGFloat) {
        self.init(size: CGSize(width: width, height: height))
    }
    
    mutating func updateWithMaxWidth(maxWidth: CGFloat) {
        self.size.width = min(self.size.width, maxWidth)
    }
    
    func roundRect() -> CGRect {
        var newRect = CGRect()
        newRect.origin.x = round(self.origin.x)
        newRect.origin.y = round(self.origin.y)
        newRect.size.width = round(self.width)
        newRect.size.height = round(self.height)
        return newRect
    }
    
    func roundOrigin() -> CGRect {
        var newRect = self
        newRect.origin.x = round(self.origin.x)
        newRect.origin.y = round(self.origin.y)
        return newRect
    }
    
    func roundSize() -> CGRect {
        var newRect = self
        newRect.size.width = round(self.width)
        newRect.size.height = round(self.height)
        return newRect
    }
    
    func withX(_ x: CGFloat) -> CGRect {
        var rect = self
        rect.origin.x = x
        return rect
    }
    
    func withY(_ y: CGFloat) -> CGRect {
        var rect = self
        rect.origin.y = y
        return rect
    }
    
    func increaseXBy(xDiff: CGFloat) -> CGRect {
        return self.withX(self.origin.x + xDiff)
    }
    
    func increaseYBy(yDiff: CGFloat) -> CGRect {
        return self.withY(self.origin.y + yDiff)
    }
    
    func increaseWidthBy(wDiff: CGFloat) -> CGRect {
        return self.withWidth(self.width + wDiff)
    }
    
    func increaseHeightBy(hDiff: CGFloat) -> CGRect {
        return self.withHeight(self.height + hDiff)
    }
    
    func withWidth(_ width: CGFloat) -> CGRect {
        var rect = self
        rect.size.width = width
        return rect
    }
    
    func withHeight(_ height: CGFloat) -> CGRect {
        var rect = self
        rect.size.height = height
        return rect
    }
    
    func withOrigin(origin: CGPoint) -> CGRect {
        var rect = self
        rect.origin = origin
        return rect
    }
    
    func withSize(size: CGSize) -> CGRect {
        var rect = self
        rect.size = size
        return rect
    }
    
    func withCenter(_ center: CGPoint) -> CGRect {
        var rect = self
        rect.origin.x = center.x - rect.width / 2
        rect.origin.y = center.y - rect.height / 2
        return rect
    }
    
    func withCenterX(x: CGFloat) -> CGRect {
        var rect = self
        rect.origin.x = x - rect.width / 2
        return rect
    }
    
    func withCenterY(y: CGFloat) -> CGRect {
        var rect = self
        rect.origin.y = y - rect.height / 2
        return rect
    }
    
    func randomCenter(in bounds: CGRect) -> CGRect {
        let w2 = width / 2
        let h2 = height / 2
        
        let x = Int.random(in: Int(bounds.minX + w2)...Int(bounds.maxX - w2))
        let y = Int.random(in: Int(bounds.minY + h2)...Int(bounds.maxY - h2))
        
        return withCenterX(x: CGFloat(x)).withCenterY(y: CGFloat(y))
    }
    
}

extension CGSize {
    
    init(side: CGFloat) {
        self.init(width: side, height: side)
    }
    
    var widthToHeightRatio: CGFloat {
        return self.width / self.height
    }
    
    var heightToWidthRatio: CGFloat {
        return self.height / self.width
    }
    
    var maxSide: CGFloat {
        return max(self.width, self.height)
    }
    
    var minSide: CGFloat {
        return min(self.width, self.height)
    }
    
    func rounded() -> CGSize {
        return CGSize(width: round(self.width), height: round(self.height))
    }
    
    func divided(by: CGFloat) -> CGSize {
        return CGSize(width: width / by, height: height / by)
    }
    
    var area: CGFloat {
        return self.width * self.height
    }
    
    func toRect() -> CGRect {
        return CGRect(size: self)
    }
    
}

extension CGRect {
    
    // MARK: - Centrize
    
    func centrize(in parentRect: CGRect) -> CGRect {
        var rect = self
        rect = rect.centrizeVertically(in: parentRect).centrizeHorizontally(in: parentRect)
        return rect
    }
    
    func centrizeVertically(in parentRect: CGRect) -> CGRect {
        var rect = self
        rect.origin.y = (parentRect.height - rect.height) / 2
        return rect
    }
    
    func centrizeHorizontally(in parentRect: CGRect) -> CGRect {
        var rect = self
        rect.origin.x = (parentRect.width - rect.width) / 2
        return rect
    }

}
