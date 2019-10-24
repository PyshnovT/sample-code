//
//  NetworkService.swift
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

enum NetworkError: String, Error {
    case noData
}

class NetworkService {
    
    typealias NetworkServiceCompletion = (Result<Data>) -> Void
    
    func load(url: URL, completion: @escaping NetworkServiceCompletion) {
        let task = URLSession.shared.dataTask(with: url) {
            data, response, error in

            DispatchQueue.main.async {
                if let error = error {
                    completion(.error(error))
                    return
                }
                
                guard let data = data else {
                    completion(.error(NetworkError.noData))
                    return
                }
                
                completion(.success(data))
            }
            
        }
        
        task.resume()
    }
    
}
