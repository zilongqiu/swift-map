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
    
    var place: Place!;
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Title
        self.menuBarTitle.title = place.name
        
        // Map
        self.locationManager.delegate = self
        self.locationManager.startUpdatingLocation()
        // Create marker
        let position = CLLocationCoordinate2DMake(place.latitude, place.longitude)
        var marker = GMSMarker(position: position)
        marker.icon = UIImage(named: place.type)
        marker.map = self.mapView;
        
        // Camera position
        let coordinate = CLLocationCoordinate2DMake(place.latitude, place.longitude)
        self.mapView.camera = GMSCameraPosition(target: coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
        self.locationManager.stopUpdatingLocation()
        
        // Text field
        var text: String = ""
        var note: Int  = Int(self.place.note)
        text = "Adresse : \(self.place.address)\n\n" +
               "Pays : \(self.place.country)\n\n" +
               "Note : \(note)/20\n\n" +
               "Type : \(self.place.type)\n\n"
        
        if(!self.place.comment.isEmpty) {
            text += "Commentaire : \(self.place.comment)"
        }
        self.textField.text = text
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
