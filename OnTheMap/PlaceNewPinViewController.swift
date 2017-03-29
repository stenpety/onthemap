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
        
        
        
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
}
