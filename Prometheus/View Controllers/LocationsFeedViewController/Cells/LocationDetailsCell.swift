//
//  LocationDetailsCell.swift
//  Prometheus
//
//  Created by Tim Pyshnov on 24/10/2019.
//  Copyright © 2019 Draewil. All rights reserved.
//

import UIKit

class LocationDetailsCell: UICollectionViewCell {

    static let reuseIdentifier = LocationDetailsCell.className
    
    var model: LocationDetailsCellModel? {
        didSet {
            if let model = model {
                update(with: model)
                setNeedsLayout()
            }
        }
    }
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(tableView)
        addSubview(separatorView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Views
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsSelection = false
        tableView.backgroundColor = .clear
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 57, bottom: 0, right: 0)
        
        tableView.register(LocationPlainDetailsCell.nib, forCellReuseIdentifier: LocationPlainDetailsCell.reuseIdentifier)
        tableView.register(LocationWindSpeedDetailsCell.nib, forCellReuseIdentifier: LocationWindSpeedDetailsCell.reuseIdentifier)
        
        return tableView
    }()
    
    lazy var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.rgba(red: 0, green: 0, blue: 0, alpha: 0.3)
        return view
    }()
    
    // MARK: - Layout
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let insets = Constants.insets
        tableView.frame = bounds.appliedInsets(insets: insets)
        
        let separatorHeight = Constants.separatorHeight / UIScreen.main.scale
        separatorView.frame = CGRect(x: 0, y: bounds.height - separatorHeight, width: bounds.width, height: separatorHeight)
    }
    
    // MARK: - Update
    
    private func update(with model: LocationDetailsCellModel) {
        tableView.reloadData()
    }
    
}

// MARK: - Layout

extension LocationDetailsCell {
    
    static func height(for model: LocationDetailsCellModel, maximumWidth: CGFloat) -> CGFloat {
        let insets = Constants.insets
        var height: CGFloat = Constants.separatorHeight
        
        for item in model.items {
            switch item {
            case .plain(let plain):
                height = height + LocationPlainDetailsCell.height(for: plain, maximumWidth: maximumWidth)
                
            case .windSpeed(let windSpeed):
                height = height + LocationWindSpeedDetailsCell.height(for: windSpeed, maximumWidth: maximumWidth)
                
            }
        }
        
        return height + insets.top + insets.bottom
    }
    
}

extension LocationDetailsCell: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model?.items.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let item = model?.items[indexPath.row] else {
            return tableView.dequeueReusableCell(withIdentifier: String(describing: UICollectionViewCell.self), for: indexPath)
        }
        
        switch item {
        case .plain(let plain):
            let cell = tableView.dequeueReusableCell(withIdentifier: LocationPlainDetailsCell.reuseIdentifier, for: indexPath) as! LocationPlainDetailsCell
            cell.model = plain
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: tableView.bounds.width)
            return cell
            
        case .windSpeed(let windSpeed):
            let cell = tableView.dequeueReusableCell(withIdentifier: LocationWindSpeedDetailsCell.reuseIdentifier, for: indexPath) as! LocationWindSpeedDetailsCell
            cell.model = windSpeed
            return cell
            
        }
    }
    
}

extension LocationDetailsCell: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let item = model?.items[indexPath.row] else {
            return 0
        }
        
        let maximumWidth = tableView.bounds.width
    
        switch item {
        case .plain(let plain):
            return LocationPlainDetailsCell.height(for: plain, maximumWidth: maximumWidth)
            
        case .windSpeed(let windSpeed):
            return LocationWindSpeedDetailsCell.height(for: windSpeed, maximumWidth: maximumWidth)
        }
        
    }
    
}

extension LocationDetailsCell {
    
    enum Constants {
        static let separatorHeight: CGFloat = 1
        static let insets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
    }
    
}
