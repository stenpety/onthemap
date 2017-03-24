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
        
        if let userName = loginTextField.text, let password = passwordTextField.text {
            let urlForLoginWithUdacity = ParseClient.sharedInstance().makeURL(apiHost: ParseClient.Constants.UdacityApiHost, apiPath: ParseClient.Constants.UdacityApiPath, withExtension: "/session", parameters: nil)
            let _ = ParseClient.sharedInstance().taskForMethod(ParseClient.MethodTypes.post, withURL: urlForLoginWithUdacity, httpHeaderFieldValue: ["Accept":"application/json", "Content-Type":"application/json"], httpBody: "{\"udacity\": {\"username\": \"\(userName)\", \"password\": \"\(password)\"}}", completionHandlerForTask: {(data, error) in
                if error == nil {
                    print("SUCCESS!!!")
                    let postSession = data as! [String:AnyObject]
                    let sessionInfo = postSession[ParseClient.UdacityResponseKeys.session] as! [String:AnyObject]
                    let sessionID = sessionInfo[ParseClient.UdacityResponseKeys.id] as! String
                    
                    print("Session ID is: \(sessionID)")
                } else {
                    print("ERROR!!!")
                }
                
            })
        }
        
    }
    
    
}

