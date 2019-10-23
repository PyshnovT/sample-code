//
//  MapViewController.swift
//  Prometheus
//
//  Created by Tim Pyshnov on 23/10/2019.
//  Copyright © 2019 Draewil. All rights reserved.
//

import UIKit
import MapKit

protocol MapViewControllerDelegate: class {
    func mapViewController(mapViewController: MapViewController, didChangeCoordinate coordinate: CLLocationCoordinate2D)
    func mapViewController(mapViewController: MapViewController, didFinishLoadingMap mapView: MKMapView)
}

class MapViewController: UIViewController {
    
    weak var delegate: MapViewControllerDelegate?
    
    lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        return mapView
    }()
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(mapView)
        mapView.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        mapView.frame = view.bounds
    }
    
}

extension MapViewController: MKMapViewDelegate {
    
    func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
        print(mapView.region)
    }
    
    func mapViewDidFinishLoadingMap(_ mapView: MKMapView) {
        delegate?.mapViewController(mapViewController: self, didFinishLoadingMap: mapView)
        print("finish loading map")
    }
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let coordinate = mapView.centerCoordinate
        delegate?.mapViewController(mapViewController: self, didChangeCoordinate: coordinate)
        print("regionDidChangeAnimated")
    }
    
}
