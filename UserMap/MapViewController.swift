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
    @IBOutlet var zoomStepper: UIStepper!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // log
        println("STATUS : APP STARTING");
        
        // Add a flag
        /*
        var marker = GMSMarker()
        marker.position = CLLocationCoordinate2DMake(41.887, -87.622)
        marker.appearAnimation = kGMSMarkerAnimationPop
        marker.icon = UIImage(named: "flag_icon")
        marker.map = self.mapView
        */
        
        // Configure view default parameters
        self.configure()
        
        // Start locationManager
        self.startLocationManager()
    }
    
    // Configure view default parameters
    func configure()
    {
        self.mapView.setMinZoom(4.0, maxZoom: 15.0)
    }
    
    // Ask access to user location
    func startLocationManager()
    {
        self.locationManager.delegate = self
        self.locationManager.requestWhenInUseAuthorization()
    }
    
    // Map Types action
    @IBAction func mapTypeSegmentPressed(sender: AnyObject) {
        let segmentedControl = sender as UISegmentedControl
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            self.mapView.mapType = kGMSTypeNormal
        case 1:
            self.mapView.mapType = kGMSTypeSatellite
        case 2:
            self.mapView.mapType = kGMSTypeHybrid
        default:
            self.mapView.mapType = kGMSTypeNormal
        }
    }
    
    // Map Zoom action
    @IBAction func zoomStepperAction(sender: UIStepper) {
        self.mapView.animateToZoom(Float(sender.value));
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
    
            // Reset camera position
            self.mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
            self.updateStepperZoomValue()
            self.locationManager.stopUpdatingLocation()
        }
    }
    
    // Update zoomStepperValue
    func updateStepperZoomValue()
    {
        self.zoomStepper.value = Double(self.mapView.camera.zoom);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

