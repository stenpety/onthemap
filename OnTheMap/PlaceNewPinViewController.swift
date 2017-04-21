//
//  PlaceNewPinViewController.swift
//  OnTheMap
//
//  Created by Petr Stenin on 29/03/2017.
//  Copyright © 2017 Petr Stenin. All rights reserved.
//

import UIKit
import MapKit

class PlaceNewPinViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: Outlets
    @IBOutlet weak var mediaURLLabel: UITextField!
    @IBOutlet weak var placeNewPinMapView: MKMapView!
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Get user's coordinated from the Model
        let myLatitude = CLLocationDegrees(ParseClient.sharedInstance().myLocation!.latitude)
        let myLongitude = CLLocationDegrees(ParseClient.sharedInstance().myLocation!.longitude)
        let myCoordinate = CLLocationCoordinate2D(latitude: myLatitude, longitude: myLongitude)
        
        // Make Map annotation from Model data
        let myLocationAnnotation = MKPointAnnotation()
        myLocationAnnotation.coordinate = myCoordinate
        myLocationAnnotation.title = "\(ParseClient.sharedInstance().myLocation!.firstName) \(ParseClient.sharedInstance().myLocation!.lastName)"
        myLocationAnnotation.subtitle = "\(ParseClient.sharedInstance().myLocation!.mediaURL)"
        
        placeNewPinMapView.addAnnotation(myLocationAnnotation)
        
        // Set mapView's region to match user's location
        let region = MKCoordinateRegionMakeWithDistance(myCoordinate, ParseClient.MapViewConstants.mapViewFineScale, ParseClient.MapViewConstants.mapViewFineScale)
        placeNewPinMapView.setRegion(region, animated: true)
        
        // Set text field delegate
        mediaURLLabel.delegate = self
    }
    
    // MARK: Actions
    @IBAction func submitPostNewPin(_ sender: UIButton) {
        guard let mediaURL = mediaURLLabel.text, mediaURL != "" else {
            showAlert(viewController: self, title: ParseClient.ErrorStrings.error, message: "Media URL cannot be empty!", actionTitle: "Dismiss")
            return
        }
        
        let latString = String(describing: ParseClient.sharedInstance().myLocation!.latitude)
        let longString = String(describing: ParseClient.sharedInstance().myLocation!.longitude)
        
        // Check whether location exists
        if ParseClient.sharedInstance().locationExists {
            ParseClient.sharedInstance().putNewLocation(locationIDToReplace: ParseClient.sharedInstance().myLocation!.objectID, mapString: (ParseClient.sharedInstance().myLocation?.mapString)!, mediaURL: mediaURL, latitude: latString, longitude: longString, completionHandlerForPutNewLocation: {(success, error) in
                
                if success {
                    performUIUpdatesOnMain {
                        // Get back to Intial view - Tab bar controller
                        self.navigationController?.dismiss(animated: true, completion: nil)
                    }
                } else {
                    performUIUpdatesOnMain {
                        
                        // Alert: PUT new location failed
                        showAlert(viewController: self, title: ParseClient.ErrorStrings.error, message: (error?.userInfo[NSLocalizedDescriptionKey] as! String), actionTitle: ParseClient.ErrorStrings.dismiss)
                    }
                }
                })
        } else {
            ParseClient.sharedInstance().postNewLocation(mapString: (ParseClient.sharedInstance().myLocation?.mapString)!, mediaURL: mediaURL, latitude: latString, longitude: longString, completionHandlerForPostNewLocation: {(success, error) in
                
                if success {
                    // Set flag to: location does exist
                    ParseClient.sharedInstance().locationExists = true
                    
                    performUIUpdatesOnMain {
                        // Get back to Intial view - Tab bar controller
                        self.navigationController?.dismiss(animated: true, completion: nil)
                    }
                } else {
                    performUIUpdatesOnMain {
                        
                        // Alert: POST new location failed
                        showAlert(viewController: self, title: ParseClient.ErrorStrings.error, message: (error?.userInfo[NSLocalizedDescriptionKey] as! String), actionTitle: ParseClient.ErrorStrings.dismiss)
                    }
                }
            })
        }
    }
    
    // MARK: Text field delegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        mediaURLLabel.resignFirstResponder()
        return true
    }
}
