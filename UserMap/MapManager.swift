//
//  MapManager.swift
//  UserMap
//
//  Created by Zi-long Qiu on 20/01/2015.
//  Copyright (c) 2015 Zilong. All rights reserved.
//

class MapManager {
    
    var mapView: GMSMapView = GMSMapView();
    
    // Show markers already in locationManager
    func showLocationMarkers(placeManager: PlaceManager)
    {
        var places = placeManager.getAll()

        for (place) in places {
            // Create marker
            self.createMarker(place.latitude, longitude: place.longitude, iconFlag: place.type)
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