//
//  AddLocationViewController.swift
//  Prometheus
//
//  Created by Tim Pyshnov on 23/10/2019.
//  Copyright © 2019 Draewil. All rights reserved.
//

import UIKit
import MapKit

protocol AddLocationViewControllerDelegate: class {
    func addLocationViewControllerDidPressBack(addLocationViewController: AddLocationViewController)
    func addLocationViewControllerDidConfirmLocation(addLocationViewController: AddLocationViewController)
}

class AddLocationViewController: UIViewController {
    
    weak var delegate: AddLocationViewControllerDelegate?
    let locationsStore: LocationsStore
    
    init(locationsStore: LocationsStore) {
        self.locationsStore = locationsStore
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Views
    
    lazy var overlayView: UIView = {
        let view = UIView()
//        view.backgroundColor = UIColor.rgba(red: 0, green: 0, blue: 0, alpha: 0.2)
        return view
    }()
    
    lazy var mapViewController: MapViewController = {
        let mapViewController = MapViewController()
        mapViewController.delegate = self
        return mapViewController
    }()
    
    lazy var panGestureRecognizer = {
        UIPanGestureRecognizer(target: self, action: #selector(pan(gr:)))
    }()
    
    lazy var pinImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AppConstants.Images.pin
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    lazy var pinShadowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AppConstants.Images.pinShadow
        return imageView
    }()
    
    lazy var toolbar: AddLocationToolbar = {
        let toolbar = AddLocationToolbar()
        toolbar.backButton.addTarget(self, action: #selector(backButtonTap(sender:)), for: .touchUpInside)
        return toolbar
    }()
    
    lazy var confirmLocationButton: PTButton = {
        let button = PTButton()
        button.setTitle(AppConstants.Strings.confirmLocation, for: .normal)
        button.setup()
        button.addTarget(self, action: #selector(confirmLocationTap(sender:)), for: .touchUpInside)
        return button
    }()
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        add(mapViewController)
        setupMapView()
        
        view.addSubview(overlayView)
        view.addSubview(toolbar)
        view.addSubview(pinImageView)
        view.addSubview(pinShadowImageView)
        view.addSubview(confirmLocationButton)
        
        state = .mapLoading
    }
    
    // MARK: - Setup
    
    private func setupMapView() {
        mapViewController.mapView.setRegion(defaultRegion, animated: false)
        mapViewController.mapView.addGestureRecognizer(panGestureRecognizer)
        panGestureRecognizer.delegate = self
    }
    
    // MARK: - Layout
    
    private var pinImageViewOffset: CGFloat = 0 {
        didSet {
            layoutPinImageView()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let buttonHeight = Constants.buttonHeight + view.safeAreaInsets.bottom
        confirmLocationButton.frame = CGRect(x: 0, y: view.bounds.height - buttonHeight, width: view.bounds.width, height: buttonHeight)
        confirmLocationButton.updateTitleEdgeInsets(bottomSafeArea: view.safeAreaInsets.bottom)
        
        toolbar.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: toolbar.intrinsicContentSize.height)
        
        mapViewController.view.frame = view.bounds.increaseHeightBy(hDiff: -buttonHeight)
        layoutPinImageView()
        
        overlayView.frame = mapViewController.view.frame
    }
    
    private func layoutPinImageView() {
        let pinSize = Constants.pinImageSize
        
        pinImageView.bounds = pinSize.toRect()
        pinImageView.center = CGPoint(
            x: view.bounds.width / 2,
            y: mapViewController.view.center.y - pinSize.height / 2 + pinImageViewOffset
        )
        
        if (pinImageViewOffset != CGFloat(0)) {
            pinShadowImageView.bounds = Constants.draggingPinShadowImageSize.toRect()
        } else {
            pinShadowImageView.bounds = Constants.pinShadowImageSize.toRect()
        }
        
        pinShadowImageView.center = CGPoint(
            x: view.bounds.width / 2,
            y: mapViewController.view.center.y
        )
    }
    
    // MARK: - State
    
    private var state: State = .mapLoading {
        didSet {
            render(state)
        }
    }
    
    private func render(_ newState: State) {
        switch newState {
        case .loading:
            hideOverlayViewIfNeeded()
            confirmLocationButton.stopAnimating()
            toolbar.locationView.model = AddLocationTitleViewModel(state: .loading)
            toolbar.setNeedsLayout()
            
        case .location(let location):
            updateLocation(location)
            
        case .mapLoading:
            confirmLocationButton.startAnimating()
            
        }
    }
    
    private func hideOverlayViewIfNeeded() {
        if overlayView.alpha > 0 {
            UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseOut], animations: {
                self.overlayView.alpha = 0
            })
        }
    }
    
    // MARK: - Content
    
    // London
    private var defaultRegion = MKCoordinateRegion(
        center: Constants.londonCoordinate,
        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    )
    
    private var lastCoordinate: CLLocationCoordinate2D?
    
    private func updateLocation(_ location: Location) {
        toolbar.locationView.model = AddLocationTitleViewModel(with: location)
        toolbar.setNeedsLayout()
    }
    
    private func fetchLocation(for coordinate: CLLocationCoordinate2D) {
        state = .loading
        
        locationsStore.fetchLocation(coordinate: coordinate) { [weak self] (result) in
            switch result {
            case .success(let location):
                self?.state = .location(location)
            case .error(let error):
                print(error)
            }
        }
        
    }
    
}

// MARK: - Actions

extension AddLocationViewController {
    
    @objc func pan(gr: UIPanGestureRecognizer) {
        
        switch gr.state {
        case .began:
            UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseOut], animations: {
                self.pinImageViewOffset = -10
            })
            
        case .failed: fallthrough
        case .cancelled: fallthrough
        case .ended:
            UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseOut], animations: {
                self.pinImageViewOffset = 0
            })
            
        default: break
        }
        
    }
    
    @objc func confirmLocationTap(sender: UIButton) {
        switch state {
        case .location(let location):
            locationsStore.insertLocation(location)
            delegate?.addLocationViewControllerDidConfirmLocation(addLocationViewController: self)
            
        case .loading:
            break
            
        case .mapLoading:
            break
        }
    }
    
    @objc func backButtonTap(sender: UIButton) {
        delegate?.addLocationViewControllerDidPressBack(addLocationViewController: self)
    }
    
}

// MARK: - MapViewControllerDelegate

extension AddLocationViewController: MapViewControllerDelegate {
    
    func mapViewController(mapViewController: MapViewController, didChangeCoordinate coordinate: CLLocationCoordinate2D) {
        lastCoordinate = coordinate
        
        switch state {
        case .mapLoading:
            break
            
        default:
            fetchLocation(for: coordinate)
        }
    }
    
    func mapViewController(mapViewController: MapViewController, didFinishLoadingMap mapView: MKMapView) {
        switch state {
        case .mapLoading:
            if let lastCoordinate = lastCoordinate {
                fetchLocation(for: lastCoordinate)
            }
            
        default:
            break
        }
    }
    
}

// MARK: - UIGestureRecognizerDelegate

extension AddLocationViewController: UIGestureRecognizerDelegate {
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
}

// MARK: - Data Types

extension AddLocationViewController {
    
    enum State {
        case location(Location)
        case loading
        case mapLoading
    }
    
}

// MARK: - Constants

extension AddLocationViewController {
    
    enum Constants {
        // should be from the current location
        static let londonCoordinate = CLLocationCoordinate2D(latitude: 51.5054, longitude: -0.1278)
        
        static let pinShadowImageSize = CGSize(width: 50, height: 50)
        static let draggingPinShadowImageSize = CGSize(width: 30, height: 30)
        static let pinImageSize = CGSize(width: 60, height: 60)
        
        static let toolbarHeight: CGFloat = 70
        static let buttonHeight: CGFloat = 70
    }
    
}

