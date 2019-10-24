//
//  LocationOverviewCell.swift
//  Prometheus
//
//  Created by Tim Pyshnov on 22/10/2019.
//  Copyright © 2019 Draewil. All rights reserved.
//

import UIKit

class LocationOverviewCell: UICollectionViewCell {
    
    var model: LocationOverviewCellModel? {
        didSet {
            if let model = model {
                update(with: model)
            }
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var coordinateLabel: UILabel!
    @IBOutlet weak var currentWeatherLabel: UILabel!
    @IBOutlet weak var summaryWeatherLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    // MARK: - Update
    
    private func update(with model: LocationOverviewCellModel) {
        titleLabel.text = model.title
        coordinateLabel.text = model.coordinate
        currentWeatherLabel.text = model.currentWeather
        summaryWeatherLabel.text = model.summaryWeather
        temperatureLabel.text = model.temperature
        
        setNeedsLayout()
    }
}

// MARK: - Layout

extension LocationOverviewCell {
    
    static func height(for model: LocationOverviewCellModel, maximumWidth: CGFloat) -> CGFloat {
        let insets = Constants.insets
        
        let maxLabelWidth = maximumWidth -
            insets.left -
            insets.right -
            Constants.viewToTemperatureViewX -
            Constants.temperatureViewSize.width
        
        let titleSize = model.title.size(for: maxLabelWidth, font: Constants.titleFont)
        let coordinateSize = model.coordinate.size(for: maxLabelWidth, font: Constants.coordinateFont)
        let currentWeatherSize = model.currentWeather?.size(for: maxLabelWidth, font: Constants.currentWeatherFont) ?? CGSize.zero
        let summaryWeatherSize = model.summaryWeather?.size(for: maxLabelWidth, font: Constants.currentWeatherFont) ?? CGSize.zero
        
        return
            insets.top +
            titleSize.height +
            Constants.titleToCoordinateY +
            coordinateSize.height +
            Constants.coordinateToCurrentWeatherY +
            currentWeatherSize.height +
            Constants.currentWeatherToSummaryWeatherY +
            summaryWeatherSize.height +
            insets.bottom
    }
    
}

// MARK: - Contstants

extension LocationOverviewCell {
    
    enum Constants {
        static let titleFont = UIFont.systemFont(ofSize: 17)
        static let coordinateFont = UIFont.systemFont(ofSize: 15)
        static let currentWeatherFont = UIFont.italicSystemFont(ofSize: 13)
        static let summaryWeatherFont = UIFont.italicSystemFont(ofSize: 13)
        
        static let insets = UIEdgeInsets(top: 20, left: 16, bottom: 10, right: 16)
        static let temperatureViewSize = CGSize(width: 60, height: 60)
        
        static let titleToCoordinateY: CGFloat = 0
        static let coordinateToCurrentWeatherY: CGFloat = 8
        static let currentWeatherToSummaryWeatherY: CGFloat = 8
        static let viewToTemperatureViewX: CGFloat = 20
    }
    
    static let nib: UINib = UINib(nibName: "LocationOverviewCell", bundle: nil)
    static let reuseIdentifier = "LocationOverviewCell"
    
}
