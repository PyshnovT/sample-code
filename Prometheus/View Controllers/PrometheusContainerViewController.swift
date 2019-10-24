//
//  PrometheusContainerViewController.swift
//  Prometheus
//
//  Created by Tim Pyshnov on 23/10/2019.
//  Copyright © 2019 Draewil. All rights reserved.
//

import UIKit

final class PrometheusContainerViewController: UIViewController {
    
    var rootViewController: UIViewController? {
        get {
            return _rootViewController
        }
        set {
            if let rootViewController = newValue {
                add(rootViewController)
                containerView.addSubview(rootViewController.view)
            } else {
                rootViewController?.remove()
            }
            
            _rootViewController = newValue
        }
    }
    
    private var _rootViewController: UIViewController?
    
    // MARK: - Views
    
    lazy var containerView: UIView = {
        UIView()
    }()
    
    lazy var navigationBar: UIView = {
        let navigationBar = UIView()
        navigationBar.backgroundColor = AppConstants.Colors.navigationBarBackgroundColor
        return navigationBar
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = AppConstants.Strings.appName
        label.font = Constants.titleFont
        label.textColor = AppConstants.Colors.navigationBarTextColor
        return label
    }()
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(containerView)
        view.addSubview(navigationBar)
        navigationBar.addSubview(titleLabel)
    }
    
    // MARK: - Layout
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let navigationBarHeight = Constants.navigationBarHeight + view.safeAreaInsets.top
        navigationBar.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: navigationBarHeight)
        
        let titleSize = titleLabel.text!.size(for: view.bounds.width, font: Constants.titleFont)
        titleLabel.frame =
            titleSize
                .toRect()
                .centrizeHorizontally(in: navigationBar.bounds)
                .withY(view.safeAreaInsets.top + (Constants.navigationBarHeight - titleSize.height) / 2)
        
        containerView.frame = CGRect(
            x: 0,
            y: navigationBarHeight,
            width: view.bounds.width,
            height: view.bounds.height - navigationBarHeight
        )
        
        rootViewController?.view.frame = containerView.bounds
    }
    
}

extension PrometheusContainerViewController {
    
    enum Constants {
        static let titleFont = UIFont.systemFont(ofSize: 18, weight: .bold)
        static let navigationBarHeight: CGFloat = 44
    }
    
}
