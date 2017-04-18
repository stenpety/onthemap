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
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Reset login-password fields
        loginTextField.text = nil
        passwordTextField.text = nil
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
}

