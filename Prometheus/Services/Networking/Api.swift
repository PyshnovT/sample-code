//
//  Api.swift
//  Prometheus
//
//  Created by Tim Pyshnov on 22/10/2019.
//  Copyright © 2019 Draewil. All rights reserved.
//

import Foundation

//
// since we have only one request there is no need
// to write super-duper-flexible networking service;
//
// but in a real app, when we have a lot of different
// urls, AUTH, tokens, etc. i would do something like this:
// https://medium.com/flawless-app-stories/writing-network-layer-in-swift-protocol-oriented-approach-4fa40ef1f908
//
// This one will do just one simple request
//

struct Api {
    
    typealias ApiWeatherCompletion = (Result<Location>) -> Void
    
    let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    // MARK: - Routes
    
    func fetchLocation(latitude: String, longitude: String, lang: String?, units: String?, completion: @escaping ApiWeatherCompletion) {
        // https://prometheus-api.draewil.net/c6987ba1fcc7450aea9cff041bb42825/51.500334,-0.085013?lang=fr&units=si
        
        var components = URLComponents()
        components.scheme = "https"
        components.host = "prometheus-api.draewil.net"
        components.path = "/\(Constants.apiKey)/\(latitude),\(longitude)"
        
        var queryItems: [URLQueryItem] = []
        
        if let lang = lang {
            queryItems.append(URLQueryItem(name: "lang", value: lang))
        }
        
        if let units = units {
            queryItems.append(URLQueryItem(name: "units", value: units))
        }
        
        components.queryItems = queryItems
        
        guard let url = components.url else {
            preconditionFailure("Failed to construct URL")
        }
        
        networkService.load(url: url) { (result) in
            switch result {
            case .success(let data):
                
                do {
                    var location = try JSONDecoder().decode(Location.self, from: data)
                    if let rawValue = units, let units = Units(rawValue: rawValue) {
                        location.currentWeather.setUnits(units)
                    }
                    completion(.success(location))
                } catch {
                    completion(.error(error))
                }
                
            case .error(let error):
                completion(.error(error))
            }
        }
    }
    
}

extension Api {
    
    enum Constants {
        static let apiKey = "c6987ba1fcc7450aea9cff041bb42825"
    }
    
}
