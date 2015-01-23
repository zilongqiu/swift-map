//
//  MapManager.swift
//  UserMap
//
//  Created by Zi-long Qiu on 20/01/2015.
//  Copyright (c) 2015 Zilong. All rights reserved.
//

import SugarRecord

class MapManager {
    
    var mapView: GMSMapView = GMSMapView();
    
    // Show markers already in database
    func showLocationMarkers(data: SugarRecordResults?)
    {
        if(data!.count > 0) {
            for index in 0..<data!.count {
                // Create marker
                var place: Place = data!.objectAtIndex(UInt(index)) as Place
                self.createMarker(place.latitude, longitude: place.longitude, iconFlag: place.type)
            }
        }
    }
    
    // Create a marker on the map
    func createMarker(latitude: CLLocationDegrees, longitude: CLLocationDegrees, iconFlag: String) {
        var position = CLLocationCoordinate2DMake(latitude, longitude)
        var marker   = GMSMarker(position: position)
        marker.icon  = UIImage(named: iconFlag)
        marker.map   = self.mapView
    }
    
    
}