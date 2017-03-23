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
    
    init(locationDictionary: [String:AnyObject]) throws {
        if let objectID = locationDictionary[ParseClient.ParseResponseKeys.objectID] as? String,
        let uniqueKey = locationDictionary[ParseClient.ParseResponseKeys.uniqueKey] as? String,
        let firstName = locationDictionary[ParseClient.ParseResponseKeys.firstName] as? String,
        let lastName = locationDictionary[ParseClient.ParseResponseKeys.lastName] as? String,
        let mapString = locationDictionary[ParseClient.ParseResponseKeys.mapString] as? String,
        let mediaURL = locationDictionary[ParseClient.ParseResponseKeys.mediaURL] as? String,
        let latitude = locationDictionary[ParseClient.ParseResponseKeys.latitude] as? Double,
            let longitude = locationDictionary[ParseClient.ParseResponseKeys.longitude] as? Double {
            self.objectID = objectID
            self.uniqueKey = uniqueKey
            self.firstName = firstName
            self.lastName = lastName
            self.mapString = mapString
            self.mediaURL = mediaURL
            self.latitude = latitude
            self.longitude = longitude
        } else {
            throw NSError(domain: "Could not initialize Student Location", code: 1, userInfo: nil)
        }
    }
}
