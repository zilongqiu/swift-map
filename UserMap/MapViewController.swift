//
//  MapViewController.swift
//  UserMap
//
//  Created by Zi-long Qiu on 09/01/2015.
//  Copyright (c) 2015 Zilong. All rights reserved.
//

import UIKit

class MapViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet var mapView: GMSMapView!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // log
        println("STATUS : APP STARTING");
        
        mapView.setMinZoom(4.0, maxZoom: 15.0)
        
        // Add a flag
        /*
        var marker = GMSMarker()
        marker.position = CLLocationCoordinate2DMake(41.887, -87.622)
        marker.appearAnimation = kGMSMarkerAnimationPop
        marker.icon = UIImage(named: "flag_icon")
        marker.map = self.mapView
        */
        
        // Ask access to user location
        self.locationManager.delegate = self
        self.locationManager.requestWhenInUseAuthorization()
        
        println("\(self.mapView.myLocation)")
        if let mylocation = self.mapView.myLocation {
            NSLog("\(mylocation)")
        } else {
            NSLog("User's location is unknown")
        }
        
    }
    
    // Invoke CLLocationManagerDelegate when the user grants or revokes location permissions
    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        
        if status == .AuthorizedWhenInUse {

            self.locationManager.startUpdatingLocation()
 
            self.mapView.myLocationEnabled = true
            self.mapView.settings.myLocationButton = true
        }
    }
    
    // CLLocationManagerDelegate executes when the location manager receives new location data
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        
        if let location = locations.first as? CLLocation {
    
            self.mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)

            self.locationManager.stopUpdatingLocation()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

