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
        
        // Configuration
        self.configure()
    }
    
    func configure() {
        // Menu bar item right icon - Map
        let mapImg = UIImage(named: "icon_map")
        self.iconMap.setBackgroundImage(mapImg, forState: .Normal, barMetrics: .Default)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.placeManager.places.count
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("placeCell") as UITableViewCell;
    
        cell.textLabel?.text = self.placeManager.places[indexPath.row].name;
    
        var imageName = UIImage(named: self.placeManager.places[indexPath.row].type);
        cell.imageView?.image = imageName;
    
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
            vc.place = self.placeManager.places[selectedIndex!.row]
        }
    }

}
