//
//  ViewController.swift
//  Prometheus
//
//  Created by Tim Pyshnov on 22/10/2019.
//  Copyright © 2019 Draewil. All rights reserved.
//

import UIKit
import CoreLocation

protocol LocationsFeedViewControllerDelegate: class {
    func locationsFeedViewControllerDidTapAddLocation(_ locationsFeedViewController: LocationsFeedViewController)
}

class LocationsFeedViewController: UIViewController {
    
    typealias Section = LocationsFeedContentViewController.Section
    
    weak var delegate: LocationsFeedViewControllerDelegate?
    
    let locationsStore: LocationsStore
    
    // MARK: - Init
    
    init(locationsStore: LocationsStore) {
        self.locationsStore = locationsStore
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Views
    
    lazy var containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var addLocationButton: PTButton = {
        let button = PTButton()
        button.setTitle("Add new location", for: .normal)
        button.setup()
        button.addTarget(self, action: #selector(addLocationTap(sender:)), for: .touchUpInside)
        return button
    }()
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.rgb(250, 250, 255)
        view.addSubview(containerView)
        view.addSubview(addLocationButton)
        
        state = .empty
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if locationsStore.locations.count > 0 {
            state = .locations(locationsStore.locations)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let buttonHeigth = Constants.buttonHeight + view.safeAreaInsets.bottom
        addLocationButton.frame = CGRect(x: 0, y: view.bounds.height - buttonHeigth, width: view.bounds.width, height: buttonHeigth)
        addLocationButton.updateTitleEdgeInsets(bottomSafeArea: view.safeAreaInsets.bottom)
        
        containerView.frame = view.bounds.increaseHeightBy(hDiff: -buttonHeigth)
        shownViewController?.view.frame = containerView.bounds
    }
    
    // MARK: - Setup
    
    private func getWeather() {
        state = .loading
        
//        let coordinate = CLLocationCoordinate2D(latitude: 51.500334, longitude: -0.085013)
//
//        locationsStore.fetchLocation(coordinate: coordinate) { [weak self] (result) in
//            switch result {
//            case .success(let location):
//                self?.state = .locations([location])
//            case .error(let error):
//                self?.state = .error(error)
//            }
//        }
    }
    
    // MARK: - State
    
    private var shownViewController: UIViewController?
    private var contentViewController: LocationsFeedContentViewController?
    
    private var state: State = .none {
        didSet {
            render(state)
        }
    }
    
    private func render(_ newState: State) {
        
        switch newState {
        case .locations(let locations):
            
            let sections = locations.map { Section(with: $0) }
            
            if let contentViewController = contentViewController, shownViewController == contentViewController {
                contentViewController.sections = sections
            } else {
                shownViewController?.remove()
                
                contentViewController = LocationsFeedContentViewController(sections: sections)
                add(contentViewController!)
                containerView.addSubview(contentViewController!.view)
                
                shownViewController = contentViewController
            }
            
        case .empty:
            
            shownViewController?.remove()
            
            let emptyViewController = EmptyViewController()
            add(emptyViewController)
            containerView.addSubview(emptyViewController.view)
            
            shownViewController = emptyViewController
            
        case .loading:
            
            shownViewController?.remove()
            
            let loaderViewController = LoaderViewController()
            add(loaderViewController)
            containerView.addSubview(loaderViewController.view)
            
            shownViewController = loaderViewController
            
        case .error:
            break
        case .none: break
        }
        
        view.setNeedsLayout()
    }

}

// MARK: - Actions

extension LocationsFeedViewController {
    
    @objc private func addLocationTap(sender: UIButton) {
        delegate?.locationsFeedViewControllerDidTapAddLocation(self)
    }
    
}

// MARK: - Data Types

extension LocationsFeedViewController {
    
    enum State {
        case none // default state
        case locations([Location])
        case empty // zero locations
        case loading
        case error(Error)
    }
    
}

// MARK: - Constants

extension LocationsFeedViewController {
    
    enum Constants {
        static let buttonHeight: CGFloat = 70
    }
    
}
