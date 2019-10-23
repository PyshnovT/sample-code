//
//  LocationsFeedContentViewController.swift
//  Prometheus
//
//  Created by Tim Pyshnov on 22/10/2019.
//  Copyright © 2019 Draewil. All rights reserved.
//

import UIKit

//protocol LocationsFeedContentViewControllerDelegate: class {
//    func locationsFeedContentViewControllerDidTapAddLocation(_ locationsFeedContentViewController: LocationsFeedContentViewController)
//}

//
// Reusable list
//
class LocationsFeedContentViewController: UIViewController {
    
    var sections: [Section] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    init(sections: [Section]) {
        self.sections = sections
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Views
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView.empty()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.alwaysBounceVertical = true
        
        collectionView.register(LocationOverviewCell.nib, forCellWithReuseIdentifier: LocationOverviewCell.reuseIdentifier)
        
        return collectionView
    }()
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(collectionView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        collectionView.frame = view.bounds
    }
    
}

// MARK: - UICollectionViewDataSource

//
// to be honest, we can go even further and make reusable data sources
// https://www.swiftbysundell.com/articles/reusable-data-sources-in-swift/
//
extension LocationsFeedContentViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections[section].items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = sections[indexPath.section].items[indexPath.item]
        
        switch item {
        case .overview(let location):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LocationOverviewCell.reuseIdentifier, for: indexPath) as! LocationOverviewCell
            cell.model = LocationOverviewCellModel(with: location)
            return cell
        default:
            return UICollectionViewCell()
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension LocationsFeedContentViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        let item = sections[indexPath.section].items[indexPath.item]
        
        switch item {
        case .overview(let location):
            let height = LocationOverviewCell.height(for: LocationOverviewCellModel(with: location), maximumWidth: width)
            return CGSize(width: width, height: height)
        default:
            return .zero
        }
    }
    
}

// MARK: - UICollectionViewDelegate

extension LocationsFeedContentViewController: UICollectionViewDelegate {
    
}