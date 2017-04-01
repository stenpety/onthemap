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
    
    // MARK: Life cycle
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
        
        // Center map on user's current location if it is set, otherwise center at Sydney
        // Don't ask why Sydney =))
        var myCoordinates = CLLocationCoordinate2D(latitude: ParseClient.MapViewConstants.defaultLatitude, longitude: ParseClient.MapViewConstants.defaultLongitude)
        if let myLocation = ParseClient.sharedInstance().myLocation {
            myCoordinates = CLLocationCoordinate2D(latitude: myLocation.latitude, longitude: myLocation.longitude)
        }
        let region = MKCoordinateRegionMakeWithDistance(myCoordinates, ParseClient.MapViewConstants.mapViewLargeScale, ParseClient.MapViewConstants.mapViewLargeScale)
        studentLocationsMapView.setRegion(region, animated: true)
    }
    
    // MARK: Map VC singleton shared instance
    class func sharedInstance() -> MapViewController {
        struct Singleton {
            static let sharedInstance = MapViewController()
        }
        return Singleton.sharedInstance
    }
}
