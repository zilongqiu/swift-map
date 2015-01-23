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
    
    var databaseManager: DatabaseManager = DatabaseManager()
    var mapManager: MapManager = MapManager()
    var firstLocationUpdate: Bool?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configure view default parameters
        self.configure()
        
        // Initialize locationManager
        self.startLocationManager()
    }
    
    // Refresh the view user permission
    override func viewWillAppear(animated: Bool) {
        self.checkStatus(CLLocationManager.authorizationStatus())
    }
    
    
    // MARK: - Configs
    func configure()
    {
        // Configure map zoom
        self.mapView.setMinZoom(4.0, maxZoom: 15.0)
        self.mapManager.mapView = self.mapView
    }
    
    // Initialize locationManager
    func startLocationManager()
    {
        // Ask access to user location
        self.locationManager.startUpdatingLocation()
        self.locationManager.delegate = self
        self.checkStatus(CLLocationManager.authorizationStatus())
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.stopUpdatingLocation()
        
        // Add all locationManager places marker
        self.locationManager.startUpdatingLocation()
        self.mapManager.showLocationMarkers(self.databaseManager.data)
        self.locationManager.stopUpdatingLocation()
        self.updateStepperZoomValue()
    }
    
    
    // MARK: - Actions
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
        self.mapView.animateToZoom(Float(sender.value))
    }
    
    // Invoke CLLocationManagerDelegate when the user grants or revokes location permissions
    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        
        self.checkStatus(status)
    }
    
    // Check the location permissions
    func checkStatus(status: CLAuthorizationStatus) {
        if status == .Authorized || status == .AuthorizedWhenInUse {
            self.mapView.myLocationEnabled         = true
            self.mapView.settings.myLocationButton = true
        }
    }
    
    // Update zoomStepperValue
    func updateStepperZoomValue()
    {
        self.zoomStepper.value = Double(self.mapView.camera.zoom)
    }
    
    // MARK: - Segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        // Allow modal to send data to the map
        if let viewController = segue.destinationViewController as? AddPlaceController {
            viewController.onDataAvailable = {[weak self]
                (iconName, data) in
                if let weakSelf = self {
                    weakSelf.modalData(iconName, data: data)
                }
            }
        }
    }
    
    // Data sended from segue on add action
    func modalData(iconName: String, data: CLPlacemark) {
        self.locationManager.startUpdatingLocation()
        
        // Create marker
        self.mapManager.createMarker(data.location.coordinate.latitude, longitude: data.location.coordinate.longitude, iconFlag: iconName)
        
        // Camera position
        self.mapView.camera = GMSCameraPosition(target: data.location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
        
        self.updateStepperZoomValue()
        self.locationManager.stopUpdatingLocation()
    }

}

