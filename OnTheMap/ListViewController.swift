//
//  ListViewController.swift
//  OnTheMap
//
//  Created by Petr Stenin on 25/03/2017.
//  Copyright © 2017 Petr Stenin. All rights reserved.
//

import UIKit

class ListViewController: UITableViewController {
    
    // MARK: Life cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Reload table data
        tableView.reloadData()
    }
    
    // MARK: TableView Delegate & Data Source functions
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return StudentDataSource.sharedInstance.studentLocations.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Get cell type
        let listCell = tableView.dequeueReusableCell(withIdentifier: ParseClient.StoryBoardIdentifiers.listCellReuseIdentifier) as UITableViewCell!
        
        // Setup cell
        listCell?.textLabel?.text = "\(StudentDataSource.sharedInstance.studentLocations[indexPath.row].firstName) \(StudentDataSource.sharedInstance.studentLocations[indexPath.row].lastName)"
        listCell?.detailTextLabel?.text = "\(StudentDataSource.sharedInstance.studentLocations[indexPath.row].mapString)"
        
        return listCell!
    }
    
    // Open the associated link (mediaURL) in a Default Browser
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Deselect row:
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let mediaURL = URL(string: StudentDataSource.sharedInstance.studentLocations[indexPath.row].mediaURL) {
            UIApplication.shared.open(mediaURL, options: [:], completionHandler: nil)
        } else {
            showAlert(viewController: self, title: ParseClient.ErrorStrings.error, message: "This student location contains no valid URL to display", actionTitle: ParseClient.ErrorStrings.dismiss)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ParseClient.ListViewConstante.tableDefaultHeight
    }
    
    // MARK: TableViewVC singleton shared instance
    class func sharedInstance () -> ListViewController {
        struct Singleton {
            static let sharedInstance = ListViewController()
        }
        return Singleton.sharedInstance
    }
}
