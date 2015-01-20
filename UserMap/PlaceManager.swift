//
//  PlaceManager.swift
//  UserMap
//
//  Created by Zi-long Qiu on 14/01/2015.
//  Copyright (c) 2015 Zilong. All rights reserved.
//

class PlaceManager {
    
    var places = [Place]();
    
    
    // Get a place at index
    func getPlaceAtIndex(index: Int) -> Place {
        return self.places[index];
    }
    
    // Get place number
    func count() -> Int {
        return self.places.count
    }
    
}