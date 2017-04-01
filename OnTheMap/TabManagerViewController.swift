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
    // Launch VC to add a new pin
    @IBAction func addNewPin(_ sender: UIBarButtonItem) {
        let addNewPinViewController = storyboard!.instantiateViewController(withIdentifier: ParseClient.StoryBoardIdentifiers.inputController) as! AddNewPinViewController
        self.present(addNewPinViewController, animated: true, completion: nil)
    }
    
    // Refresh button - common for Map and List
    @IBAction func refreshStudentLocations(_ sender: UIBarButtonItem) {
        ParseClient.sharedInstance().getAllStudentLocations(completionHandlerForGetAllStudentLocations: {(success, error) in
            if success {
                print("Database updated. What next?")
                performUIUpdatesOnMain {
                    ListViewController.sharedInstance().studentLocations = ParseClient.sharedInstance().studentLocations
                    ListViewController.sharedInstance().tableView.reloadData()
                    // TODO: Refresh map view
                }
            } else {
                print(error!)
            }
        })
    }
    
    @IBAction func logOut(_ sender: UIBarButtonItem) {
        ParseClient.sharedInstance().deleteSessionID(completionHandlerForDeleteSessionID: {(success, error) in
            if success {
                print("ID deleted")
                performUIUpdatesOnMain {
                    let loginViewController = self.storyboard!.instantiateViewController(withIdentifier: ParseClient.StoryBoardIdentifiers.loginViewController)
                    self.present(loginViewController, animated: true, completion: nil)
                }
            } else {
                print(error!)
            }
        })
    }
}
