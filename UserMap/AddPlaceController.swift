//
//  AddPlaceController.swift
//  UserMap
//
//  Created by Zi-long Qiu on 14/01/2015.
//  Copyright (c) 2015 Zilong. All rights reserved.
//

import Foundation
import UIKit
import AddressBookUI

class AddPlaceController: UITableViewController, CLLocationManagerDelegate {

    @IBOutlet var name: UITextField!
    @IBOutlet var address: UITextField!
    @IBOutlet var note: UISlider!
    @IBOutlet var type: UIPickerView!
    @IBOutlet var comment: UITextView!
    @IBOutlet var navigationBar: UINavigationBar!
    
    let placeHolderText: String            = "Commentaire"
    let locationManager: CLLocationManager = CLLocationManager()
    
    var placeManager: PlaceManager!
    var geocoder: CLGeocoder = CLGeocoder()
    var types                = ["Restaurant","Hotel","Monument","Musee","Autres"]
    var typeSelected: String = ""
    var onDataAvailable : ((iconName: String, data: CLPlacemark) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configure view default parameters
        self.configure()
    }
    
    
    // MARK: - Configs
    func configure()
    {
        // Set border for text view
        self.comment.layer.borderWidth  = 0.5
        self.comment.layer.borderColor  = UIColor.lightGrayColor().CGColor
        self.comment.layer.cornerRadius = 5.0
    }
    
    // Send placemark mark if exist to MapViewController
    func sendData(iconName: String, data: CLPlacemark) {
        self.onDataAvailable?(iconName: iconName, data: data)
    }
    
    
    // MARK: - Actions
    
    // Set current address to the text field if the user permissions
    @IBAction func currentAddress(sender: AnyObject) {
        // Ask access to user location
        self.locationManager.startUpdatingLocation()
        self.locationManager.delegate = self
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.stopUpdatingLocation()
        
        // Check status
        if CLLocationManager.authorizationStatus() != .Authorized && CLLocationManager.authorizationStatus() != .AuthorizedWhenInUse {
            let alert     = UIAlertView()
            alert.title   = "Géolocalisation"
            alert.message = "Veuillez autoriser la géolocalisation de votre appareil !"
            alert.addButtonWithTitle("J'ai compris !")
            alert.show()
        }
        else {
            var currentLocation = self.locationManager.location
            geocoder.reverseGeocodeLocation(self.locationManager.location, completionHandler:{(placemarks, error) in
                if (error != nil) {
                    println("reverse geodcode fail: \(error.localizedDescription)")
                }
                
                let pm = placemarks as [CLPlacemark]
                if pm.count > 0 {
                    let currentPlacemark: CLPlacemark = placemarks[0] as CLPlacemark
                    self.address.text = ABCreateStringWithAddressDictionary(currentPlacemark.addressDictionary, true)
                }
            })
        }
    }

    // Dismiss the modal
    @IBAction func cancel(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: {})
    }

    // Save place
    @IBAction func save(sender: AnyObject) {
        
        if(self.name.text.isEmpty || self.address.text.isEmpty) {
            let alert     = UIAlertView()
            alert.title   = "Erreur"
            alert.message = "Veuillez saisir les champs obligatoires !"
            alert.addButtonWithTitle("J'ai compris !")
            alert.show()
        }
        else {
            var place     = Place()
            place.name    = self.name.text
            place.type    = (self.typeSelected == "") ? self.types[0] : self.typeSelected
            place.address = self.address.text
            place.note    = self.note.value
            
            // Don't retrieve the comment if its equal to placeHolderText
            if(self.comment.text != placeHolderText) {
                place.comment = self.comment.text
            }
            
            geocoder.geocodeAddressString(self.address.text, {(placemarks: [AnyObject]!, error: NSError!) -> Void in
                if let placemark = placemarks?[0] as? CLPlacemark {
                    place.longitude = placemark.location.coordinate.longitude
                    place.latitude  = placemark.location.coordinate.latitude
                    place.country   = placemark.country
                    
                    // Send new location in MapViewController
                    self.sendData(place.type, data: placemark)
                }
            })
            
            // Add a Place in the manager
            self.placeManager.places.append(place)
            
            // Dismiss the modal
            self.dismissViewControllerAnimated(true, completion: {})
        }
        
    }
    
    
    // MARK: - Table
    // Configure table row height
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if(indexPath.row == 3 || indexPath.row == 4){
            return CGFloat(150.0)
        }else{
            return CGFloat(44.0)
        }
    }

    
    // MARK: - Text field
    // Close the keyboard on return
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    // Check if the comment content is the placeHolderText
    func textViewShouldBeginEditing(textView: UITextView) -> Bool {
        self.comment.textColor = UIColor.blackColor()
        
        if(self.comment.text == placeHolderText) {
            self.comment.text = ""
        }
        
        return true
    }
    
    // Check if comment empty on keyboard close
    func textViewDidEndEditing(textView: UITextView) {
        if(self.comment.text == "") {
            self.comment.text = placeHolderText
            self.comment.textColor = UIColor.lightGrayColor()
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        if(self.comment.text == "") {
            self.comment.text = placeHolderText
            self.comment.textColor = UIColor.lightGrayColor()
        } else {
            self.comment.text = self.comment.text
            self.comment.textColor = UIColor.blackColor()
        }
    }
    
    // Check if we need to remove the fake placeholder
    func textViewDidChange(textView: UITextView){
        if countElements(textView.text) >= 1 {
            let lastChar = textView.text.substringFromIndex(advance(textView.text.endIndex, -1))
            if(lastChar == "\n"){
                textView.text = textView.text.substringToIndex(advance(textView.text.endIndex, -1))
                textView.resignFirstResponder()
            }
        }
    }
    
    
    // MARK: - Type Picker
    // Configure the picker view number of displayed element
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // Configure the picker row number
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.types.count
    }
    
    // Display each picker row name
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return self.types[row]
    }
    
    // Get the picker row selected
    func pickerView(pickerView: UIPickerView!, didSelectRow row: Int, inComponent component: Int)
    {
        self.typeSelected = self.types[row]
    }
    
    
}
