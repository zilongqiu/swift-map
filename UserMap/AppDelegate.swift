//
//  AppDelegate.swift
//  UserMap
//
//  Created by Zi-long Qiu on 09/01/2015.
//  Copyright (c) 2015 Zilong. All rights reserved.
//

import UIKit
import SugarRecord

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    // YOUR_GOOGLE_IOS_API_KEY
    let googleMapsApiKey = "AIzaSyDb1c2pqWjmf6y5eojXCzwqety8sD0z83s"

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        // Instantiate Google Maps services
        GMSServices.provideAPIKey(googleMapsApiKey)

        return true
    }
    
    // SugarRecord lifecycle is REQUIRED in order to execute cleaning and saving internal tasks
    func applicationWillResignActive(application: UIApplication!) {
        SugarRecord.applicationWillResignActive()
    }
    
    func applicationWillEnterForeground(application: UIApplication!) {
        SugarRecord.applicationWillEnterForeground()
    }
    
    func applicationWillTerminate(application: UIApplication!) {
        SugarRecord.applicationWillTerminate()
    }

}

