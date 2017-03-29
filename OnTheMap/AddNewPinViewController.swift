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
    var userLatitude: String?
    var userLongitude: String?
    
    let locationManager = CLLocationManager()
    
    // MARK: Outlets
    @IBOutlet weak var setNewLocationTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Setup location manager
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        
        CLLocationManager.locationServicesEnabled()
        locationManager.startUpdatingLocation()
    }
    
    // MARK: Actions
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func findOnTheMap(_ sender: UIButton) {
        // TODO: Temp function - for test only!
        ParseClient.sharedInstance().postNewLocation(mapString: "test Map string", mediaURL: "www.test.ru", latitude: userLatitude!, longitude: userLongitude!, completionHandlerForPostNewLocation: {(success, error) in
        })
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0] 
        let lat = userLocation.coordinate.latitude
        let long = userLocation.coordinate.longitude
        
        userLatitude = lat.description
        userLongitude = long.description
    }
    
    
}
