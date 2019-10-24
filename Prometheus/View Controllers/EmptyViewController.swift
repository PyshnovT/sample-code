
//
//  EmptyViewController.swift
//  Prometheus
//
//  Created by Tim Pyshnov on 23/10/2019.
//  Copyright © 2019 Draewil. All rights reserved.
//

import UIKit

class EmptyViewController: UIViewController {
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AppConstants.Images.emptyBox?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = Constants.contentColor
        return imageView
    }()
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.text = AppConstants.Strings.addLocations
        label.font = Constants.labelFont
        label.textColor = Constants.contentColor
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(imageView)
        view.addSubview(label)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let imageSize = Constants.imageViewSize
        
        label.bounds = label.text!.size(for: view.bounds.width, font: Constants.labelFont).toRect()
        label.center = CGPoint(x: view.bounds.width / 2, y: view.bounds.height / 2 + Constants.contentOffset)
        
        imageView.frame = imageSize.toRect().centrizeHorizontally(in: view.bounds).withY(label.frame.minY - imageSize.height - Constants.imageViewToLabelY)
    }
    
}

// MARK: - Constants

extension EmptyViewController {
    
    enum Constants {
        static let imageViewSize = CGSize(width: 80, height: 80)
        static let labelFont = UIFont.systemFont(ofSize: 20)
        
        static let imageViewToLabelY: CGFloat = 16
        static let contentOffset: CGFloat = 40
        
        static let contentColor = UIColor.rgb(red: 155, green: 155, blue: 155)
    }
    
}
