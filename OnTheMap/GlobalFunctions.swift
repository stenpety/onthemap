//
//  GlobalFunctions.swift
//  OnTheMap
//
//  Created by Petr Stenin on 25/03/2017.
//  Copyright © 2017 Petr Stenin. All rights reserved.
//

import Foundation
import UIKit

// Perform updates on Main queue
func performUIUpdatesOnMain(_ updates: @escaping () -> Void) {
    DispatchQueue.main.async {
        updates()
    }
}

// Show alert for errors, messages etc.
func showAlert(viewController: UIViewController, title: String, message: String?, actionTitle: String) -> Void {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: actionTitle, style: .default, handler: nil))
    
    viewController.present(alert, animated: true, completion: nil)
}
