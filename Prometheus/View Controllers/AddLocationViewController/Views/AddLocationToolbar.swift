//
//  AddLocationToolbar.swift
//  Prometheus
//
//  Created by Tim Pyshnov on 23/10/2019.
//  Copyright © 2019 Draewil. All rights reserved.
//

import UIKit

//
// since we can't change UINavigationBar height, we need to create a custom view
//
class AddLocationToolbar: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(backgroundView)
        addSubview(effectView)
        addSubview(separatorView)
        addSubview(locationView)
        addSubview(backButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Views
    
    lazy var effectView: UIVisualEffectView = {
        let effect = UIBlurEffect(style: .prominent)
        return UIVisualEffectView(effect: effect)
    }()
    
    lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.rgba(red: 255, green: 255, blue: 255, alpha: 0.97)
        return view
    }()
    
    lazy var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.rgba(red: 0, green: 0, blue: 0, alpha: 0.2)
        return view
    }()
    
    lazy var locationView: AddLocationTitleView = {
        AddLocationTitleView()
    }()
    
    lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(AppConstants.Images.chevronLeft, for: .normal)
        button.setTitle("Back", for: .normal)
        button.titleLabel?.font = Constants.buttonFont
//        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
        return button
    }()
    
    // MARK: - Layout
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        effectView.frame = bounds
        backgroundView.frame = bounds
        separatorView.frame = CGRect(
            x: 0,
            y: bounds.height - Constants.separatorHeight,
            width: bounds.width,
            height: Constants.separatorHeight)
        
        let topInset = Constants.topInset
        
        backButton.sizeToFit()
        backButton.frame = backButton.bounds.withX(8).centrizeVertically(in: bounds).increaseYBy(yDiff: topInset / 2)
        
        locationView.frame = locationView.intrinsicContentSize.toRect().centrize(in: bounds).increaseYBy(yDiff: topInset / 2)
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: bounds.width, height: Constants.height)
    }
    
}

extension AddLocationToolbar {
    
    enum Constants {
        static let topInset: CGFloat = 20
        static let height: CGFloat = 70
        static let separatorHeight: CGFloat = 1 / UIScreen.main.scale
        
        static let buttonFont = UIFont.systemFont(ofSize: 18)
    }
    
}

