//
//  AddNewPinViewController.swift
//  OnTheMap
//
//  Created by Petr Stenin on 26/03/2017.
//  Copyright © 2017 Petr Stenin. All rights reserved.
//

import UIKit
import MapKit

class AddNewPinViewController: UIViewController {
    
    // MARK: Properties
    var userLatitude: Double?
    var userLongitude: Double?
    
    // MARK: Outlets
    @IBOutlet weak var setNewLocationTextField: UITextField!
    
    // MARK: Actions
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // TODO: Search locations' coordinates
    @IBAction func findOnTheMap(_ sender: UIButton) {
        
        if let mapString = setNewLocationTextField.text, mapString != "" {
            // Change corresponding myLocation properties: mapString, Udacity ID, and coordinates
            
            ParseClient.sharedInstance().myLocation?.mapString = mapString
            ParseClient.sharedInstance().myLocation?.uniqueKey = ParseClient.Constants.petrSteninUdacityID
            
            let geocoder = CLGeocoder()
            geocoder.geocodeAddressString(mapString, completionHandler: {(placemarks, error) in
                if let placemark = placemarks?[0] {
                    ParseClient.sharedInstance().myLocation?.latitude = placemark.location!.coordinate.latitude
                    ParseClient.sharedInstance().myLocation?.longitude = placemark.location!.coordinate.longitude
                    print("GEOCODED!")
                    let placeNewPinVC = self.storyboard!.instantiateViewController(withIdentifier: ParseClient.StoryBoardIdentifiers.placeNewPinController) as! PlaceNewPinViewController
                    self.navigationController?.pushViewController(placeNewPinVC, animated: true)
                }
            })
            
            
        } else {
            showAlert(viewController: self, title: ParseClient.ErrorStrings.error, message: "Location name cannot be empty!", actionTitle: ParseClient.ErrorStrings.dismiss)
        }
    }
    
    // MARK: Singleton shared instance
    // TODO: Do I need it?
    class func sharedInstance() -> AddNewPinViewController {
        struct Singleton {
            static let sharedInstance = AddNewPinViewController()
        }
        return Singleton.sharedInstance
    }
}
