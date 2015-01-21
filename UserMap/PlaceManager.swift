//
//  PlaceManager.swift
//  UserMap
//
//  Created by Zi-long Qiu on 14/01/2015.
//  Copyright (c) 2015 Zilong. All rights reserved.
//

import AddressBookUI

class PlaceManager {
    
    var places               = [Place]()
    var geocoder: CLGeocoder = CLGeocoder()
    
    // Get all elements
    func getAll() -> [Place] {
        return self.places
    }
    
    func add(place: Place) {
        self.places.append(place)
    }
    
    // Get place at index
    func getAtIndex(index: Int) -> Place {
        return self.places[index]
    }
    
    // Get place number
    func count() -> Int {
        return self.places.count
    }
    
}