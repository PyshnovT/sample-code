//
//  LocationWindBearingDetailsCell.swift
//  Prometheus
//
//  Created by Tim Pyshnov on 24/10/2019.
//  Copyright © 2019 Draewil. All rights reserved.
//

import UIKit

class LocationWindSpeedDetailsCell: UITableViewCell {

    typealias WindSpeedDetails = LocationDetailsCellModel.WindSpeedDetails
    
    static let nib = UINib(nibName: "LocationWindSpeedDetailsCell", bundle: nil)
    static let reuseIdentifier = "LocationWindSpeedDetailsCell"
    
    var model: WindSpeedDetails? {
        didSet {
            if let model = model {
                setGradientColors(model.gradientColors)
                titleLabel.text = model.title
                subtitleLabel.text = model.subtitle
                
                if let windBearing = model.windBearing?.degrees.value {
                    windBearingImageView?.isHidden = false
                    
                    windBearingImageView.transform = CGAffineTransform(rotationAngle: CGFloat(degreesToRadians(windBearing)))
                } else {
                    windBearingImageView?.isHidden = true
                }
            }
        }
    }
    
   // MARK: - Views
    
    @IBOutlet weak var gradientView: GradientView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var windBearingImageView: UIImageView!
    
    // MARK: - Update
    
    private func setGradientColors(_ gradientColors: [UIColor]) {
        gradientView.gradientColors = gradientColors
    }
    
}

extension LocationWindSpeedDetailsCell {
    
    static func height(for model: WindSpeedDetails, maximumWidth: CGFloat) -> CGFloat {
        return 50
    }
    
}
