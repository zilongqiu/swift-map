//
//  PlaceDetailController.swift
//  UserMap
//
//  Created by Zi-long Qiu on 18/01/2015.
//  Copyright (c) 2015 Zilong. All rights reserved.
//

import UIKit

class PlaceDetailController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet var mapView: GMSMapView!
    @IBOutlet var textField: UITextView!
    @IBOutlet var menuBarTitle: UINavigationItem!
    
    let locationManager: CLLocationManager = CLLocationManager()
    
    var place: Place!
    var mapManager: MapManager = MapManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mapManager.mapView = self.mapView

        // Menu bar title
        self.menuBarTitle.title = place.name
        
        // Map
        self.locationManager.delegate = self
        self.locationManager.startUpdatingLocation()
        self.mapManager.createMarker(place.latitude, longitude: place.longitude, iconFlag: place.type)
        let coordinate = CLLocationCoordinate2DMake(place.latitude, place.longitude)
        self.mapView.camera = GMSCameraPosition(target: coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
        self.locationManager.stopUpdatingLocation()
        
        // Text field
        var text: String = ""
        var note: Int    = Int(self.place.note)
        text             = "Adresse : \(self.place.address)\n\n" +
                           "Pays : \(self.place.country)\n\n" +
                           "Note : \(note)/20\n\n" +
                           "Type : \(self.place.type)\n\n"
        
        if(!self.place.comment.isEmpty) {
            text += "Commentaire : \(self.place.comment)"
        }
        self.textField.text = text
    }
    
}
