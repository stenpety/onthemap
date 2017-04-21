//
//  LoginViewController.swift
//  OnTheMap
//
//  Created by Petr Stenin on 22/03/2017.
//  Copyright © 2017 Petr Stenin. All rights reserved.
//

import UIKit
import MapKit

class LoginViewController: UIViewController, CLLocationManagerDelegate {
    
    // MARK: properties
    let locationManager = CLLocationManager()
    
    // MARK: Outlets
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup location manager
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        
        // Start Location manager
        CLLocationManager.locationServicesEnabled()
        locationManager.startUpdatingLocation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Reset login-password fields
        loginTextField.text = nil
        passwordTextField.text = nil
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        locationManager.stopUpdatingLocation()
    }
    
    // MARK: Actions
    
    @IBAction private func loginWithUdacity(_ sender: UIButton) {
        
        ParseClient.sharedInstance().getSessionAndUserID(loginVC: self, completionHandlerForLogin: {(success, error) in
            if success {
                ParseClient.sharedInstance().getInitialUserInfo(completionHandlerForGetIserInfo: {(success, error) in
                    if success {
                        ParseClient.sharedInstance().getAllStudentLocations(completionHandlerForGetAllStudentLocations: {(success, error) in
                            if success {
                                performUIUpdatesOnMain {
                                    self.completeLogin()
                                }
                            } else {
                                performUIUpdatesOnMain {
                                    showAlert(viewController: self, title: ParseClient.ErrorStrings.error, message: error?.description, actionTitle: ParseClient.ErrorStrings.dismiss)
                                }
                            }
                        })
                    } else {
                        performUIUpdatesOnMain {
                            showAlert(viewController: self, title: ParseClient.ErrorStrings.error, message: error?.description, actionTitle: ParseClient.ErrorStrings.dismiss)
                        }
                    }
                })
            } else {
                performUIUpdatesOnMain {
                    showAlert(viewController: self, title: ParseClient.ErrorStrings.error, message: error?.description, actionTitle: ParseClient.ErrorStrings.dismiss)
                }
            }
        })
    }
    
    private func completeLogin() {
        let navigationManagerController = storyboard!.instantiateViewController(withIdentifier: ParseClient.StoryBoardIdentifiers.navigationManagerController) as! UINavigationController
        self.present(navigationManagerController, animated: true, completion: nil)
    }
    
    // MARK: Location Manager Delegate Functions
    // Get user's coordinates and update Model's properties
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0]
        ParseClient.sharedInstance().myLocation?.latitude = userLocation.coordinate.latitude
        ParseClient.sharedInstance().myLocation?.longitude = userLocation.coordinate.longitude
    }
}

