//
//  StudentDataSource.swift
//  OnTheMap
//
//  Created by Petr Stenin on 22/04/2017.
//  Copyright © 2017 Petr Stenin. All rights reserved.
//

import UIKit

// Singleton class to store all students data and user's own data
class StudentDataSource: NSObject {
    
    // MARK: Properties
    // Main data storage property
    var studentLocations = [StudentLocation]()
    
    // Properties to store user's own data
    var myLocation: StudentLocation?
    
    // Flag to indicate that location exists. Default value is 'false'
    var locationExists = false
    
    // MARK: Singleton
    // Make a shared instance of StudentDataSource class
    static let sharedInstance = StudentDataSource()
    
    // Prevents initialization of this class
    private override init() {}
}
