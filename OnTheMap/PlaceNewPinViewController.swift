//
//  PlaceNewPinViewController.swift
//  OnTheMap
//
//  Created by Petr Stenin on 29/03/2017.
//  Copyright © 2017 Petr Stenin. All rights reserved.
//

import UIKit
import MapKit

class PlaceNewPinViewController: UIViewController {
    
    // MARK: Outlets
    @IBOutlet weak var mediaURLLabel: UITextField!
    @IBOutlet weak var placeNewPinMapView: MKMapView!
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: Actions
    
    @IBAction func submitPostNewPin(_ sender: UIButton) {
        if let mediaURL = mediaURLLabel.text, mediaURL != "" {
            let latString = String(describing: ParseClient.sharedInstance().myLocation!.latitude)
            let longString = String(describing: ParseClient.sharedInstance().myLocation!.longitude)
            
            ParseClient.sharedInstance().postNewLocation(mapString: (ParseClient.sharedInstance().myLocation?.mapString)!, mediaURL: mediaURL, latitude: latString, longitude: longString, completionHandlerForPostNewLocation: {(success, error) in
                
                if success {
                    performUIUpdatesOnMain {
                        self.dismiss(animated: true, completion: nil)
                    }
                } else {
                    // TODO: Handle error
                }
                })
        
        }
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
}
