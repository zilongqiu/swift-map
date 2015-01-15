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
        
        // Add some places
        let place1 = Place()
        place1.name = "Wc Donalds"
        place1.type = "Restaurant"
        self.placeManager.places.append(place1)
        self.tableView.reloadData()
        
        let place2 = Place()
        place2.name = "DFC"
        place2.type = "Restaurant"
        self.placeManager.places.append(place2)
        self.tableView.reloadData()
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
            println("LOG : showMap Segue performed")
            let vc = segue.destinationViewController as MapViewController
            vc.placeManager = self.placeManager
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
