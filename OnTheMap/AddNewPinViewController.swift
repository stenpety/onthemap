//
//  AddNewPinViewController.swift
//  OnTheMap
//
//  Created by Petr Stenin on 26/03/2017.
//  Copyright © 2017 Petr Stenin. All rights reserved.
//

import UIKit
import MapKit

class AddNewPinViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: Outlets
    @IBOutlet weak var setNewLocationTextField: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNewLocationTextField.delegate = self
    }
    
    
    // MARK: Actions
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func findOnTheMap(_ sender: UIButton) {
        
        self.view.bringSubview(toFront: activityIndicator)
        activityIndicator.startAnimating()
        
        if let mapString = setNewLocationTextField.text, mapString != "" {
            
            // Change corresponding myLocation properties: mapString, Udacity ID, and coordinates
            StudentDataSource.sharedInstance.myLocation?.mapString = mapString
            StudentDataSource.sharedInstance.myLocation?.uniqueKey = ParseClient.Constants.petrSteninUdacityID
            
            let geocoder = CLGeocoder()
            geocoder.geocodeAddressString(mapString, completionHandler: {(placemarks, error) in
                if let placemark = placemarks?[0] {
                    StudentDataSource.sharedInstance.myLocation?.latitude = placemark.location!.coordinate.latitude
                    StudentDataSource.sharedInstance.myLocation?.longitude = placemark.location!.coordinate.longitude
                    self.activityIndicator.stopAnimating()
                    
                    // Instantiate and push PlaceNewPinVC
                    let placeNewPinVC = self.storyboard!.instantiateViewController(withIdentifier: ParseClient.StoryBoardIdentifiers.placeNewPinController) as! PlaceNewPinViewController
                    self.navigationController?.pushViewController(placeNewPinVC, animated: true)
                } else {
                    self.activityIndicator.stopAnimating()
                    showAlert(viewController: self, title: ParseClient.ErrorStrings.error, message: "Could not geocode your location!", actionTitle: ParseClient.ErrorStrings.dismiss)
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
    
    // MARK: Text Field Delegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        setNewLocationTextField.resignFirstResponder()
        return true
    }
}
