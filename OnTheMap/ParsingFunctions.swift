//
//  ParsingFunctions.swift
//  OnTheMap
//
//  Created by Petr Stenin on 24/03/2017.
//  Copyright © 2017 Petr Stenin. All rights reserved.
//

import Foundation

// Functions for extracting required data from serialized JSONs
extension ParseClient {
    
    // Send Request and retrieve Session ID & User ID
    func getSessionAndUserID(loginVC: LoginViewController, completionHandlerForLogin: @escaping (_ success: Bool, _ error: NSError?) -> Void) -> Void {
        
        if let userName = loginVC.loginTextField.text, let password = loginVC.passwordTextField.text {
            let urlForLoginWithUdacity = ParseClient.sharedInstance().makeURL(apiHost: ParseClient.Constants.UdacityApiHost, apiPath: ParseClient.Constants.UdacityApiPath, withExtension: "/session", parameters: nil)
            let _ = ParseClient.sharedInstance().taskForMethod(ParseClient.MethodTypes.post, withURL: urlForLoginWithUdacity, httpHeaderFieldValue: [ParseClient.JSONHeaderField.accept:ParseClient.JSONHeaderValues.appJSON, ParseClient.JSONHeaderField.contentType:ParseClient.JSONHeaderValues.appJSON], httpBody: "{\"udacity\": {\"username\": \"\(userName)\", \"password\": \"\(password)\"}}", completionHandlerForTask: {(data, error) in
                if error == nil {
                    print("SUCCESS!!! ==got session ID & user ID==")
                    let postSession = data as! [String:AnyObject]
                    
                    // Set client shared instance's property: sessionID
                    let sessionInfo = postSession[ParseClient.UdacityResponseKeys.session] as! [String:AnyObject]
                    if let sessionID = sessionInfo[ParseClient.UdacityResponseKeys.id] as? String {
                        ParseClient.sharedInstance().sessionID = sessionID
                    } else {
                        completionHandlerForLogin(false, NSError(domain: "getSessionAndUserID", code: 1, userInfo: [NSLocalizedDescriptionKey:"Cannot retrieve info: \(ParseClient.UdacityResponseKeys.id)"]))
                    }
                    
                    
                    // Set client shared instance's property: userID
                    let accountInfo = postSession[ParseClient.UdacityResponseKeys.account] as! [String:AnyObject]
                    if let userID = accountInfo[ParseClient.UdacityResponseKeys.key] as? String {
                        ParseClient.sharedInstance().userID = userID
                    } else {
                        completionHandlerForLogin(false, NSError(domain: "getSessionAndUserID", code: 1, userInfo: [NSLocalizedDescriptionKey:"Cannot retrieve info: \(ParseClient.UdacityResponseKeys.key)"]))
                    }
                    
                    // Launch completion handler with parms for successful option
                    completionHandlerForLogin(true, nil)
                    
                } else {
                    // Launch completion handler with parms for unsuccessful option
                    completionHandlerForLogin(false, error)
                }
            })
        }
    }
    
    // Retrieve initial user information: first name and last name
    func getInitialUserInfo(completionHandlerForGetIserInfo: @escaping (_ success: Bool, _ error: NSError?) -> Void) -> Void {
        let urlForGetUserInfo = ParseClient.sharedInstance().makeURL(apiHost: ParseClient.Constants.UdacityApiHost, apiPath: ParseClient.Constants.UdacityApiPath, withExtension: "/users/\(ParseClient.sharedInstance().userID!)", parameters: nil)
        let _ = ParseClient.sharedInstance().taskForMethod(ParseClient.MethodTypes.get, withURL: urlForGetUserInfo, httpHeaderFieldValue: [:], httpBody: nil, completionHandlerForTask: {(data, error) in
            // TODO: change to guard
            if error == nil {
                print("SUCCESS!!! ==got User Info==")
                let getUserData = data as! [String:AnyObject]
                
                // Set client shared instance's properties: user first & last names
                let userInfo = getUserData[ParseClient.UdacityUserData.user] as! [String:AnyObject]
                if let userFirstName = userInfo[ParseClient.UdacityUserData.firstName] as? String, let userLastName = userInfo[ParseClient.UdacityUserData.lastName] as? String {
                    ParseClient.sharedInstance().userFirstName = userFirstName
                    ParseClient.sharedInstance().userLastName = userLastName
                    completionHandlerForGetIserInfo(true, nil)
                } else {
                    completionHandlerForGetIserInfo(false, NSError(domain: "getInitialUserInfo", code: 1, userInfo: [NSLocalizedDescriptionKey:"Cannot retrieve user info: \(ParseClient.UdacityUserData.firstName), \(ParseClient.UdacityUserData.lastName)"]))
                }
            } else {
                completionHandlerForGetIserInfo(false, error)
            }
            
        })
    }
    
    // Get a full list of Student Locations
    func getAllStudentLocations(completionHandlerForGetAllStudentLocations: @escaping (_ success: Bool, _ error: NSError?) -> Void) -> Void {
        let urlForGetAllStudentLocations = ParseClient.sharedInstance().makeURL(apiHost: ParseClient.Constants.ParseApiHost, apiPath: ParseClient.Constants.ParseApiPath, withExtension: nil, parameters: nil)
        let _ = ParseClient.sharedInstance().taskForMethod(ParseClient.MethodTypes.get, withURL: urlForGetAllStudentLocations, httpHeaderFieldValue: ParseClient.JSONHeaderCommon.jsonHeaderCommonParse, httpBody: nil, completionHandlerForTask: {(data, error) in
            
            guard error == nil else {
                completionHandlerForGetAllStudentLocations(false, error)
                return
            }
            
            let locationsData = data as! [String:AnyObject]
            guard let arrayOfLocationDicts = locationsData[ParseClient.ParseResponseKeys.results] as? [[String:AnyObject]] else {
                completionHandlerForGetAllStudentLocations(false, NSError(domain: "getAllStudentsLocations", code: 1, userInfo: [NSLocalizedDescriptionKey:"Could not parse locations data"]))
                return
            }
            
            print("I got to iterating through arrayOfLocations!")
            for location in arrayOfLocationDicts {
                do {
                    let studentLocation = try StudentLocation(location)
                    ParseClient.sharedInstance().studentLocations.append(studentLocation)
                    print("I tried to init location..")
                } catch {
                    // TODO: launch completion handler with proper error
                }
            }
            completionHandlerForGetAllStudentLocations(true,nil)
            })
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
