//
//  LoaderViewController.swift
//  Prometheus
//
//  Created by Tim Pyshnov on 23/10/2019.
//  Copyright © 2019 Draewil. All rights reserved.
//

import UIKit

class LoaderViewController: UIViewController {
    
    lazy var loader: UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView(style: .gray)
        loader.hidesWhenStopped = true
        return loader
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(loader)
        
        loader.startAnimating()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        loader.center = CGPoint(x: view.bounds.width / 2, y: view.bounds.height / 2)
    }
    
}
