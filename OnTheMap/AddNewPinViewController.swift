//
//  AddNewPinViewController.swift
//  OnTheMap
//
//  Created by Petr Stenin on 26/03/2017.
//  Copyright © 2017 Petr Stenin. All rights reserved.
//

import UIKit
import CoreLocation

class AddNewPinViewController: UIViewController, CLLocationManagerDelegate {
    
    // MARK: Properties
    var userLatitude: Double?
    var userLongitude: Double?
    
    let locationManager = CLLocationManager()
    
    // MARK: Outlets
    @IBOutlet weak var setNewLocationTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Setup location manager
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        
        // Start Location manager
        CLLocationManager.locationServicesEnabled()
        locationManager.startUpdatingLocation()
    }
    
    // MARK: Actions
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func findOnTheMap(_ sender: UIButton) {
        
        if let mapString = setNewLocationTextField.text, mapString != "" {
            // Init myLocation property of ParseClient with first/last name and coordinates
            ParseClient.sharedInstance().myLocation = try! StudentLocation([ParseClient.ParseResponseKeys.firstName: ParseClient.sharedInstance().userFirstName! as AnyObject,
                                                                            ParseClient.ParseResponseKeys.lastName: ParseClient.sharedInstance().userLastName! as AnyObject,
                                                                            ParseClient.ParseResponseKeys.latitude:userLatitude! as AnyObject,
                                                                            ParseClient.ParseResponseKeys.longitude:userLongitude! as AnyObject])
            ParseClient.sharedInstance().myLocation?.mapString = mapString
            ParseClient.sharedInstance().myLocation?.uniqueKey = ParseClient.Constants.petrSteninUdacityID
            
            let placeNewPinVC = storyboard!.instantiateViewController(withIdentifier: ParseClient.StoryBoardIdentifiers.placeNewPinController) as! PlaceNewPinViewController
            self.present(placeNewPinVC, animated: true, completion: nil)
        } else {
            print("Print something there...")
            // TODO: Implement pop-up notification 'No text'
        }
    }
    
    // MARK: Location Manager Delegate Functions
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0] 
        let lat = userLocation.coordinate.latitude
        let long = userLocation.coordinate.longitude
        
        userLatitude = lat
        userLongitude = long
    }
    
    // MARK: Singleton shared instance
    class func sharedInstance() -> AddNewPinViewController {
        struct Singleton {
            static let sharedInstance = AddNewPinViewController()
        }
        return Singleton.sharedInstance
    }
}
