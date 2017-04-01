//
//  LocationDetailsViewController.swift
//  OnTheMap
//
//  Created by Petr Stenin on 25/03/2017.
//  Copyright © 2017 Petr Stenin. All rights reserved.
//

import UIKit

class LocationDetailsViewController: UIViewController {
    
    // MARK: properties
    var studentLocation: StudentLocation?
    
    // MARK: Outlets
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var mapStringLabel: UILabel!
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    @IBOutlet weak var mediaURLLabel: UILabel!
    
    
    
    // MARK: Life cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let studentLocation = self.studentLocation else {
            showAlert(viewController: self, title: ParseClient.ErrorStrings.error, message: "No data loaded".description, actionTitle: ParseClient.ErrorStrings.dismiss)
            return
        }
        
        firstNameLabel.text = studentLocation.firstName != "" ? studentLocation.firstName : "Unnamed"
        lastNameLabel.text = studentLocation.lastName != "" ? studentLocation.lastName : "Unnamed"
        mapStringLabel.text = studentLocation.mapString != "" ? studentLocation.mapString : "Unknown location"
        latitudeLabel.text = "\(studentLocation.latitude)"
        longitudeLabel.text = "\(studentLocation.longitude)"
        mediaURLLabel.text = "\(studentLocation.mediaURL)"
    }
}
