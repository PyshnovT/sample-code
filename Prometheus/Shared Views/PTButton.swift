//
//  PTButton.swift
//  Prometheus
//
//  Created by Tim Pyshnov on 23/10/2019.
//  Copyright © 2019 Draewil. All rights reserved.
//

import UIKit

class PTButton: UIButton {
    
    var highlightedColor: UIColor = AppConstants.Colors.highlightedBlueColor
    private var defaultBackgroundColor: UIColor? = AppConstants.Colors.lightBlueColor
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(loader)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Views
    
    lazy var loader: UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView(style: .white)
        loader.hidesWhenStopped = true
        return loader
    }()
    
    // MARK: - UIButton
    
    override var backgroundColor: UIColor? {
        didSet {
            if backgroundColor != highlightedColor {
                defaultBackgroundColor = backgroundColor
            }
        }
    }
    
    override var isHighlighted: Bool {
        didSet {
            setupBackgroundColor()
        }
    }
    
    // MARK: - Setup
    
    private func setupBackgroundColor() {
        backgroundColor = isHighlighted ? highlightedColor : defaultBackgroundColor
    }
    
    func setup() {
        setTitle(title(for: .normal)?.uppercased(), for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: .regular)
        setupBackgroundColor()
        
        layer.shadowOpacity = 1
        layer.shadowColor = UIColor.rgba(red: 0, green: 0, blue: 0, alpha: 0.2).cgColor
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shadowRadius = 20
    }
    
    // MARK: - Layout
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        loader.center = titleLabel?.center ?? CGPoint(x: bounds.width / 2, y: bounds.height / 2)
    }
    
    // MARK: - Loading
    
    func startAnimating() {
        titleLabel?.alpha = 0
        loader.startAnimating()
    }
    
    func stopAnimating() {
        titleLabel?.alpha = 1
        loader.stopAnimating()
    }
    
}
