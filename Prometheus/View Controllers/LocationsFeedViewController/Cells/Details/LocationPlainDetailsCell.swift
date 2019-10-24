//
//  LocationPlainDetailsCell.swift
//  Prometheus
//
//  Created by Tim Pyshnov on 24/10/2019.
//  Copyright © 2019 Draewil. All rights reserved.
//

import UIKit

class LocationPlainDetailsCell: UITableViewCell {

    typealias PlainDetails = LocationDetailsCellModel.PlainDetails
    
    static let nib = UINib(nibName: LocationPlainDetailsCell.className, bundle: nil)
    static let reuseIdentifier = LocationPlainDetailsCell.className
    
    var model: PlainDetails? {
        didSet {
            if let model = model {
                setGradientColors(model.gradientColors)
                titleView.text = model.title
                subtitleView.text = model.subtitle
            }
        }
    }
    
    // MARK: - Views

    @IBOutlet weak var gradientView: GradientView!
    @IBOutlet weak var titleView: UILabel!
    @IBOutlet weak var subtitleView: UILabel!
    
    // MARK: - Update
    
    private func setGradientColors(_ gradientColors: [UIColor]) {
        gradientView.gradientColors = gradientColors
    }
    
}

extension LocationPlainDetailsCell {
    
    static func height(for model: PlainDetails, maximumWidth: CGFloat) -> CGFloat {
        return 50
    }
    
}
