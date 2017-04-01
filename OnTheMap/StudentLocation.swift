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
    
    init(_ locationDictionary: [String:AnyObject]) throws {
        
        // Set the most important properties
        if let firstName = locationDictionary[ParseClient.ParseResponseKeys.firstName] as? String,
        let lastName = locationDictionary[ParseClient.ParseResponseKeys.lastName] as? String,
        let latitude = locationDictionary[ParseClient.ParseResponseKeys.latitude] as? Double,
            let longitude = locationDictionary[ParseClient.ParseResponseKeys.longitude] as? Double {
            self.firstName = firstName
            self.lastName = lastName
            self.latitude = latitude
            self.longitude = longitude
        } else {
            throw NSError(domain: "StudentLocation.init", code: 1, userInfo: [NSLocalizedDescriptionKey:"Could not initialize Student Location"])
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
        
        if let mediaURL = locationDictionary[ParseClient.ParseResponseKeys.mediaURL] as? String {
            self.mediaURL = mediaURL
        } else {
            self.mediaURL = ""
        }
    }
}
