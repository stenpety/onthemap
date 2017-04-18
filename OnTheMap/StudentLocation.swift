//
//  StudentLocation.swift
//  OnTheMap
//
//  Created by Petr Stenin on 23/03/2017.
//  Copyright © 2017 Petr Stenin. All rights reserved.
//

import Foundation

struct StudentLocation {
    var objectID: String
    var uniqueKey: String
    var firstName: String
    var lastName: String
    var mapString: String
    var mediaURL: String
    var latitude: Double
    var longitude: Double
    
    // Failable initializer - returns nil if any of key properties is NOT set
    init?(_ locationDictionary: [String:AnyObject]) {
        
        // Check & Set the most important properties
        if let firstName = locationDictionary[ParseClient.ParseResponseKeys.firstName] as? String,
        let lastName = locationDictionary[ParseClient.ParseResponseKeys.lastName] as? String,
        let latitude = locationDictionary[ParseClient.ParseResponseKeys.latitude] as? Double,
        let longitude = locationDictionary[ParseClient.ParseResponseKeys.longitude] as? Double,
        let mediaURL = locationDictionary[ParseClient.ParseResponseKeys.mediaURL] as? String {
            self.firstName = firstName
            self.lastName = lastName
            self.latitude = latitude
            self.longitude = longitude
            self.mediaURL = mediaURL
        } else {
            return nil
        }
        
        // Set less important properties, assign with empty string if not in parameter dictonary
        if let objectID = locationDictionary[ParseClient.ParseResponseKeys.objectID] as? String {
            self.objectID = objectID
        } else {
            self.objectID = ""
        }
        
        if let uniqueKey = locationDictionary[ParseClient.ParseResponseKeys.uniqueKey] as? String {
            self.uniqueKey = uniqueKey
        } else {
            self.uniqueKey = ""
        }
        
        if let mapString = locationDictionary[ParseClient.ParseResponseKeys.mapString] as? String {
            self.mapString = mapString
        } else {
            self.mapString = ""
        }
    }
}
