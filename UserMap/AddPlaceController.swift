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

class AddPlaceController: UITableViewController {

    @IBOutlet var name: UITextField!
    @IBOutlet var address: UITextField!
    @IBOutlet var note: UISlider!
    @IBOutlet var type: UIPickerView!
    @IBOutlet var comment: UITextView!
    @IBOutlet var navigationBar: UINavigationBar!
    
    let placeHolderText = "Commentaire"
    let locationManager = CLLocationManager()
    
    var placeManager: PlaceManager!
    var geocoder             = CLGeocoder()
    var types                = ["Restaurant","Hotel","Monument","Musee","Autres"]
    var typeSelected: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set border for text view
        self.comment.layer.borderWidth  = 0.5
        self.comment.layer.borderColor  = UIColor.lightGrayColor().CGColor
        self.comment.layer.cornerRadius = 5.0
    }
    
    // MARK: - Actions
    @IBAction func currentAddress(sender: AnyObject) {
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

    @IBAction func cancel(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: {});
    }

    @IBAction func save(sender: AnyObject) {
        
        if(self.name.text.isEmpty || self.address.text.isEmpty) {
            let alert     = UIAlertView()
            alert.title   = "Erreur"
            alert.message = "Veuillez saisir les champs obligatoires !"
            alert.addButtonWithTitle("J'ai compris !")
            alert.show()
        }
        else {
            var place = Place()
            place.name    = self.name.text
            place.type    = (self.typeSelected == "") ? self.types[0] : self.typeSelected
            place.address = self.address.text
            place.note    = self.note.value
            place.comment = self.comment.text
            
            geocoder.geocodeAddressString(self.address.text, {(placemarks: [AnyObject]!, error: NSError!) -> Void in
                if let placemark = placemarks?[0] as? CLPlacemark {
                    place.longitude = Float(placemark.location.coordinate.longitude)
                    place.latitude  = Float(placemark.location.coordinate.latitude)
                }
            })
            
            self.placeManager.places.append(place);
            self.dismissViewControllerAnimated(true, completion: {});
        }
        
    }
    
    // MARK: - Table
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if(indexPath.row == 3 || indexPath.row == 4){
            return CGFloat(150.0)
        }else{
            return CGFloat(44.0)
        }
    }

    // MARK: - Text field
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        self.view.endEditing(true);
        return false;
    }
    
    func textViewShouldBeginEditing(textView: UITextView) -> Bool {
        
        self.comment.textColor = UIColor.blackColor()
        
        if(self.comment.text == placeHolderText) {
            self.comment.text = ""
        }
        
        return true
    }
    
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
    
    // MARK: - Text view
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
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.types.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return self.types[row]
    }
    
    func pickerView(pickerView: UIPickerView!, didSelectRow row: Int, inComponent component: Int)
    {
        self.typeSelected = self.types[row]
    }
    
    
}
