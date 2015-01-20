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
    
    var placeManager = PlaceManager();

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configure view default parameters
        self.configure()
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
        return self.placeManager.count()
    }

    // Cell configuration
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("placeCell") as UITableViewCell;
        
        // Get the place
        var place = self.placeManager.getPlaceAtIndex(indexPath.row)
    
        // Place name
        cell.textLabel?.text = place.name
    
        // Place type icon
        var imageName = UIImage(named: place.type)
        cell.imageView?.image = imageName
    
        return cell;
    }
    
    // MARK: - Segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "showMap") {
            let vc = segue.destinationViewController as MapViewController
            vc.placeManager = self.placeManager
        }
        else if (segue.identifier == "placeDetail") {
            let selectedIndex = self.tableView.indexPathForCell(sender as UITableViewCell)
            let vc = segue.destinationViewController as PlaceDetailController
            vc.place = self.placeManager.getPlaceAtIndex(selectedIndex!.row)
        }
    }

}
