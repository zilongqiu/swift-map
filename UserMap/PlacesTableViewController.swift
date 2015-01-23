//
//  PlacesTableViewController.swift
//  UserMap
//
//  Created by Zi-long Qiu on 13/01/2015.
//  Copyright (c) 2015 Zilong. All rights reserved.
//

import UIKit

class PlacesTableViewController: UITableViewController {
    
    @IBOutlet var iconMap: UIBarButtonItem!
    
    var databaseManager: DatabaseManager = DatabaseManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configure view default parameters
        self.configure()
    }
    
    // Refresh tableView data
    override func viewWillAppear(animated: Bool) {
        self.databaseManager.fetchData()
        self.tableView.reloadData()
    }
    
    
    // MARK: - Configs
    func configure() {
        // Menu bar item right icon - Map
        let mapImg = UIImage(named: "icon_map")
        self.iconMap.setBackgroundImage(mapImg, forState: .Normal, barMetrics: .Default)
    }
    
    
    // MARK: - Table view data source
    // Section number
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    // Row number
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (self.databaseManager.data == nil) { return 0 }
        else { return self.databaseManager.data!.count }
    }

    // Cell configuration
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("placeCell") as UITableViewCell
        
        // Get the place
        let model = self.databaseManager.data![indexPath.row] as Place
    
        // Place data
        cell.textLabel?.text  = model.name
        var imageName         = UIImage(named: model.type)
        cell.imageView?.image = imageName
    
        return cell
    }
    
    // Delete row method
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == .Delete) {
            let model = self.databaseManager.data![indexPath.row] as Place
            model.beginWriting().delete().endWriting()
            self.databaseManager.fetchData()
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }
    
    // MARK: - Segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "placeDetail") {
            let selectedIndex = self.tableView.indexPathForCell(sender as UITableViewCell)
            let vc            = segue.destinationViewController as PlaceDetailController
            vc.place          = self.databaseManager.data![selectedIndex!.row] as Place
        }
    }

}
