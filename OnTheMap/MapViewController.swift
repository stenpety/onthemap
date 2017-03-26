//
//  MapViewController.swift
//  OnTheMap
//
//  Created by Petr Stenin on 25/03/2017.
//  Copyright © 2017 Petr Stenin. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    
    // MARK: Properties
    var studentLocations = [StudentLocation]()
    
    // MARK: Outlets
    @IBOutlet weak var studentLocationsMapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        studentLocations = ParseClient.sharedInstance().studentLocations
        var annotations = [MKPointAnnotation]()
        for studentLocation in studentLocations {
            let latitude = CLLocationDegrees(studentLocation.latitude)
            let longitude = CLLocationDegrees(studentLocation.longitude)
            
            let studentLocationCoordinate = CLLocationCoordinate2DMake(latitude, longitude)
            
            let studentLocationAnnotation = MKPointAnnotation()
            studentLocationAnnotation.coordinate = studentLocationCoordinate
            studentLocationAnnotation.title = "\(studentLocation.firstName) \(studentLocation.lastName)"
            studentLocationAnnotation.subtitle = "\(studentLocation.mediaURL)"
            
            annotations.append(studentLocationAnnotation)
        }
        
        studentLocationsMapView.addAnnotations(annotations)
    }
    
    // MARK: Map VC singleton shared instance
    class func sharedInstance() -> MapViewController {
        struct Singleton {
            static let sharedInstance = MapViewController()
        }
        return Singleton.sharedInstance
    }
}
