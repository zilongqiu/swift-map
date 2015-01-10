//
//  ViewController.swift
//  UserMap
//
//  Created by Zi-long Qiu on 09/01/2015.
//  Copyright (c) 2015 Zilong. All rights reserved.
//

import UIKit

class MapViewController: UIViewController {

    @IBOutlet var mapView: GMSMapView!
    @IBOutlet var mapCenterPin: UIImageView!
    
    override func viewDidLoad() {
        // log
        println("STATUS : APP STARTING");
        
        super.viewDidLoad()

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

