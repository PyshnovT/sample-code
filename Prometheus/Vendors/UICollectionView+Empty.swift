//
//  UICollectionView+Empty.swift
//  Prometheus
//
//  Created by Tim Pyshnov on 22/10/2019.
//  Copyright © 2019 Draewil. All rights reserved.
//

import UIKit

public extension UICollectionView {
    
    static func empty() -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collection
    }
    
}
