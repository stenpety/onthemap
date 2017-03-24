//
//  ParseConstants.swift
//  OnTheMap
//
//  Created by Petr Stenin on 23/03/2017.
//  Copyright © 2017 Petr Stenin. All rights reserved.
//

import Foundation

extension ParseClient {
    
    // MARK: General URL request constants
    struct Constants {
        // API keys for Parse/Udacity
        static let parseAppID = "QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr"
        static let restAPIKey = "QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY"
        
        // API keys for Facebook
        static let facebookApiID = "365362206864879"
        static let facebookURLSchemeSuffix = "onthemap"
        
        // URL
        static let ApiScheme = "https"
        static let ParseApiHost = "parse.udacity.com"
        static let UdacityApiHost = "www.udacity.com"
        static let ParseApiPath = "/parse/classes/StudentLocation"
        static let UdacityApiPath = "/api"
    }
    
    // MARK: Types of HTTP Methods
    enum MethodTypes: String {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
        case delete = "DELETE"
    }
    
    // MARK: Keys for request/response dictionaries
    struct ParseResponseKeys {
        static let results = "results"
        static let objectID = "objectID"
        static let uniqueKey = "uniqueKey"
        static let firstName = "firstName"
        static let lastName = "lastName"
        static let mapString = "mapString"
        static let mediaURL = "mediaURL"
        static let latitude = "latitude"
        static let longitude = "longitude"
        static let createdAt = "createdAt"
        static let updatedAt = "updatedAt"
        static let acl = "ACL"
    }
    
    struct UdacityResponseKeys {
        static let session = "session"
        static let id = "id"
        static let account = "account"
        static let registered = "registered"
        static let key = "key"
    }
    
    
}
