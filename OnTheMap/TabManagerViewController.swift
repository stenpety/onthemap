//
//  TabManagerViewController.swift
//  OnTheMap
//
//  Created by Petr Stenin on 25/03/2017.
//  Copyright © 2017 Petr Stenin. All rights reserved.
//

import UIKit

class TabManagerViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: Actions
    
    @IBAction func putNewPin(_ sender: UIBarButtonItem) {
        // TODO: implement send request for new pin
    }
    
    // Refresh button - common for Map and List
    @IBAction func refreshStudentLocations(_ sender: UIBarButtonItem) {
        ParseClient.sharedInstance().getAllStudentLocations(completionHandlerForGetAllStudentLocations: {(success, error) in
            if success {
                print("Database updated. What next?")
                ListViewController.sharedInstance().tableView.reloadData()
            } else {
                print(error!)
            }
        })
    }
    
    
    @IBAction func logOut(_ sender: UIBarButtonItem) {
        // TODO: implement log out
    }
    
    
    
}
