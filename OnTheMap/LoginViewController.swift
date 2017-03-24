//
//  LoginViewController.swift
//  OnTheMap
//
//  Created by Petr Stenin on 22/03/2017.
//  Copyright © 2017 Petr Stenin. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    // MARK: Outlets
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    // MARK: Actions
    
    @IBAction private func loginWithUdacity(_ sender: UIButton) {
        
        ParseClient.sharedInstance().getSessionAndUserID(loginVC: self, completionHandlerForLogin: {(success, error) in
            if success {
                print("Session ID: ", ParseClient.sharedInstance().sessionID!)
                print("User ID: ", ParseClient.sharedInstance().userID!)
                ParseClient.sharedInstance().getInitialUserInfo(completionHandlerForGetIserInfo: {(success, error) in
                    if success {
                        print("First Name: ", ParseClient.sharedInstance().userFirstName!)
                        print("Last Name: ", ParseClient.sharedInstance().userLastName!)
                        ParseClient.sharedInstance().getAllStudentLocations(completionHandlerForGetAllStudentLocations: {(success, error) in
                            if success {
                                print(ParseClient.sharedInstance().studentLocations.count)
                            }
                            // TODO: Handle error
                        })
                    } else {
                        print("ERROR: ", error!)
                    }
                    
                    
                })
            } else {
                print("ERROR: ", error!)
            }
        })
        
    }
    
    private func completeLogin() {
        // TODO: Instantiate and present Navigation controller
    }
    
}

