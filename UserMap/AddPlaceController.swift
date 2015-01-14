//
//  AddPlaceController.swift
//  UserMap
//
//  Created by Zi-long Qiu on 14/01/2015.
//  Copyright (c) 2015 Zilong. All rights reserved.
//

import Foundation
import UIKit

class AddPlaceController: UITableViewController {

    @IBOutlet var name: UITextField!
    @IBOutlet var address: UITextField!
    @IBOutlet var note: UISlider!
    @IBOutlet var type: UIPickerView!
    @IBOutlet var comment: UITextView!
    
    var placeManager: PlaceManager!
    var types = ["Burger","Hotel","Green","Blue"]
    var typeSelected: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func submit(sender: AnyObject) {
        
        var error = false;
        
        if(self.name.text.isEmpty || self.address.text.isEmpty) {
            error = true;
        }
        
        if(error) {
            let alert = UIAlertView()
            alert.title = "Erreur"
            alert.message = "Veuillez saisir les champs obligatoires !"
            alert.addButtonWithTitle("J'ai compris !")
            alert.show()
        }
        else {
            var place = Place()
            place.name    = name.text;
            place.type    = self.typeSelected
            place.address = address.text;
            
            self.placeManager.places.append(place);
            self.dismissViewControllerAnimated(true, completion: {});
        }
        
    }
    
    // MARK: - Text field
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        self.view.endEditing(true);
        return false;
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
