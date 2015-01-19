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
    
    var placeManager: PlaceManager!;
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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

            self.locationManager.stopUpdatingLocation()
        }
    }
    
    // Update zoomStepperValue
    func updateStepperZoomValue()
    {
        self.zoomStepper.value = Double(self.mapView.camera.zoom);
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
        
        if (segue.identifier == "addPlace") {
            let vc = segue.destinationViewController as AddPlaceController
            vc.placeManager = self.placeManager
        }
    }
    
    // Modal data sended
    func modalData(iconName: String, data: CLPlacemark) {
        self.locationManager.startUpdatingLocation()
        
        // Create marker
        var position = CLLocationCoordinate2DMake(data.location.coordinate.latitude, data.location.coordinate.longitude)
        var marker = GMSMarker(position: position)
        marker.icon = UIImage(named: iconName)
        marker.map = self.mapView;
        
        // Camera position
        self.mapView.camera = GMSCameraPosition(target: data.location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
        
        self.updateStepperZoomValue()
        self.locationManager.stopUpdatingLocation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}

