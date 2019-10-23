//
//  AddLocationTitleView.swift
//  Prometheus
//
//  Created by Tim Pyshnov on 23/10/2019.
//  Copyright © 2019 Draewil. All rights reserved.
//

import UIKit

class AddLocationTitleView: UIView {
    
    var model: AddLocationTitleViewModel? {
        didSet {
            if let model = model {
                update(with: model)
            }
        }
    }
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(titleLabel)
        addSubview(coordinateLabel)
        addSubview(loader)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Views
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.titleFont
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    lazy var coordinateLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.coordinateFont
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    lazy var loader: UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView(style: .gray)
        loader.hidesWhenStopped = true
        return loader
    }()
    
    // MARK: - Layout
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let width = bounds.width
        
        let titleSize = titleLabel.text?.size(for: width, font: Constants.titleFont) ?? CGSize.zero
        titleLabel.frame = CGRect(x: 0, y: 0, width: width, height: titleSize.height)
        
        let coordinateSize = coordinateLabel.text?.size(for: width, font: Constants.titleFont) ?? CGSize.zero
        coordinateLabel.frame = CGRect(x: 0, y: titleLabel.frame.maxY + Constants.titleToCoordinateY, width: width, height: coordinateSize.height)
        
        loader.center = CGPoint(x: width / 2, y: bounds.height / 2)
    }
    
    override var intrinsicContentSize: CGSize {
        guard let model = model else { return .zero }
        
        switch model.state {
        case .location(let location):
            
            let titleSize = location.title.size(for: CGFloat.greatestFiniteMagnitude, font: Constants.titleFont)
            let coordinateSize = location.coordinate.size(for: CGFloat.greatestFiniteMagnitude, font: Constants.titleFont)
            
            return CGSize(width: max(titleSize.width, coordinateSize.width), height: titleSize.height + Constants.titleToCoordinateY + coordinateSize.height)
            
        case .loading:
            return loader.intrinsicContentSize
        }
    }
    
    // MARK: - Update
    
    private func update(with model: AddLocationTitleViewModel) {
        switch model.state {
        case .location(let location):
            titleLabel.text = location.title
            coordinateLabel.text = location.coordinate
            titleLabel.isHidden = false
            coordinateLabel.isHidden = false
            
            loader.stopAnimating()
        case .loading:
            titleLabel.isHidden = true
            coordinateLabel.isHidden = true
            
            loader.startAnimating()
        }
        
        setNeedsLayout()
    }

}

// MARK: - Contants

extension AddLocationTitleView {
    
    enum Constants {
        static let titleFont = UIFont.systemFont(ofSize: 17, weight: .medium)
        static let coordinateFont = UIFont.systemFont(ofSize: 14, weight: .medium)
        
        static let titleToCoordinateY: CGFloat = 0
    }
    
}

struct AddLocationTitleViewModel {
    
    enum State {
        case loading
        case location(TitleViewLocation)
    }
    
    struct TitleViewLocation {
        let title: String
        let coordinate: String
    }
    
    let state: State
   
}

extension AddLocationTitleViewModel {
    
    init(with location: Location) {
        self.state = .location(
            AddLocationTitleViewModel.TitleViewLocation(title: location.timezone, coordinate: location.coordinateString)
        )
    }
    
}
