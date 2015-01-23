//
//  Place.swift
//  UserMap
//
//  Created by Zi-long Qiu on 14/01/2015.
//  Copyright (c) 2015 Zilong. All rights reserved.
//

@objc(Place)
class Place: NSManagedObject {
    
    @NSManaged var name: String
    @NSManaged var type: String
    @NSManaged var address: String
    @NSManaged var country: String
    @NSManaged var note: Float
    @NSManaged var comment: String?
    @NSManaged var longitude: Double
    @NSManaged var latitude: Double
    
}