//
//  RealmAdapter.swift
//  Prometheus
//
//  Created by Tim Pyshnov on 24/10/2019.
//  Copyright © 2019 Draewil. All rights reserved.
//

import Foundation
import RealmSwift

class RealmAdapter {
    
    let realm: Realm
    
    init?() {
        do {
            self.realm = try Realm()
        } catch {
            preconditionFailure("Delete this app and run again. Everything should be fine ;)")
            return nil
        }
    }
    
    // MARK: - List
    
    private var locationsList: RealmLocationsList?
    
}

extension RealmAdapter: ReadableDatabase {
    
    func loadLocations() -> [Location] {
        locationsList = realm.objects(RealmLocationsList.self).first
        return locationsList?.data.map { Location(with: $0) } ?? []
    }
    
}

extension RealmAdapter: WritableDatabase {
    
    func saveLocations(_ locations: [Location]) {
        try! realm.write { [weak self] in
            
            if let locationsList = self?.locationsList {
                locationsList.data.removeAll()
                locationsList.data.append(objectsIn: locations.map { RealmLocation(with: $0) })
            } else {
                realm.add(RealmLocationsList(with: locations))
            }
            
        }
    }
    
}
