//
//  ParseConstants.swift
//  OnTheMap
//
//  Created by Petr Stenin on 23/03/2017.
//  Copyright © 2017 Petr Stenin. All rights reserved.
//

import Foundation
import UIKit

extension ParseClient {
    
    // MARK: URL request & JSON
    // Constants for URL requests
    struct Constants {
        // URL
        static let ApiScheme = "https"
        static let ParseApiHost = "parse.udacity.com"
        static let UdacityApiHost = "www.udacity.com"
        static let ParseApiPath = "/parse/classes/StudentLocation"
        static let UdacityApiPath = "/api"
        
        static let petrSteninUdacityID = "3523299535"
    }
    
    // JSON Header - Fields
    struct JSONHeaderField {
        static let contentType = "Content-Type"
        static let accept = "Accept"
        static let xParseREST = "X-Parse-REST-API-Key"
        static let xParseAppID = "X-Parse-Application-Id"
        static let xsrfToken = "X-XSRF-TOKEN"
    }
    
    // JSON Header - Values
    struct JSONHeaderValues {
        static let appJSON = "application/json"
        
        // API keys for Parse/Udacity
        static let restAPIKey = "QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY"
        static let parseAppID = "QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr"
        
        // API keys for Facebook
        static let facebookApiID = "365362206864879"
        static let facebookURLSchemeSuffix = "onthemap"
    }
    
    // Array of common parameters: API keys for Parse
    struct JSONHeaderCommon {
        static let jsonHeaderCommonParse = [JSONHeaderField.xParseREST:JSONHeaderValues.restAPIKey,
                                            JSONHeaderField.xParseAppID:JSONHeaderValues.parseAppID]
    }
    
    // MARK: Types of HTTP Methods
    enum MethodTypes: String {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
        case delete = "DELETE"
    }
    
    // MARK: Keys for request/response dictionaries
    // Example: get-student-location.json, post-student-location.json, put-student-location.json
    struct ParseResponseKeys {
        static let results = "results"
        static let objectID = "objectId"
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
    
    // Example: post-session.json
    struct UdacityResponseKeys {
        static let session = "session"
        static let id = "id"
        static let account = "account"
        static let registered = "registered"
        static let key = "key"
    }
    
    // Example: get-user-data.json
    struct UdacityUserData {
        static let user = "user"
        static let firstName = "first_name"
        static let lastName = "last_name"
    }
    
    // MARK: StoryBoard identifiers
    struct StoryBoardIdentifiers {
        static let loginViewController = "LoginViewController"
        static let listCellReuseIdentifier = "ListTableCell"
        static let navigationManagerController = "NavigationManagerController"
        static let locationDetailsController = "LocationDetailsController"
        static let inputController = "InputController"
        static let placeNewPinController = "PlaceNewPinController"
        static let navigationInputController = "NavigationInputController"
    }
    
    // MARK: View constants
    struct MapViewConstants {
        static let mapViewFineScale: Double = 50000
        static let mapViewLargeScale: Double = 500000
        static let defaultLatitude = -33.86785
        static let defaultLongitude = 151.20732
        static let pinReusableIdentifier = "locationPin"
    }
    
    struct ListViewConstante {
        static let tableDefaultHeight: CGFloat = 50
    }
    
    struct ErrorStrings {
        static let error = "ERROR"
        static let dismiss = "Dismiss"
        static let success = "SUCCESS"
    }
}
