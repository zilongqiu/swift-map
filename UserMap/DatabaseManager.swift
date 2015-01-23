//
//  DatabaseManager.swift
//  UserMap
//
//  Created by Zi-long Qiu on 22/01/2015.
//  Copyright (c) 2015 Zilong. All rights reserved.
//

import SugarRecord

class DatabaseManager {
    
    let databaseName = "CoreData.sqlite"
    
    var stack: SugarRecordStackProtocol?
    var data: SugarRecordResults?
    
    internal let model: NSManagedObjectModel = {
        let modelPath: NSString = NSBundle.mainBundle().pathForResource("UserMap", ofType: "momd")!
        let model: NSManagedObjectModel = NSManagedObjectModel(contentsOfURL: NSURL(fileURLWithPath: modelPath)!)!
        return model
    }()
    
    init() {
        if(self.stack == nil) {
            self.stack = DefaultCDStack(databaseName: self.databaseName, model: self.model, automigrating: true)
            (self.stack as DefaultCDStack).autoSaving = true
            SugarRecord.addStack(self.stack!)
            self.fetchData()
        }
    }
    
    func fetchData() {
        self.data = Place.all().find()
    }
    
    func fetchData(sortFieldName: String, ascending: Bool) {
        self.data = Place.all().sorted(by: sortFieldName, ascending: ascending).find()
    }
    
    func dropDatabase() {
        SugarRecord.removeAllStacks()
    }
    
}