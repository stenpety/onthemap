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
        return ParseClient.sharedInstance().studentLocations.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Get cell type
        let listCell = tableView.dequeueReusableCell(withIdentifier: ParseClient.StoryBoardIdentifiers.listCellReuseIdentifier) as UITableViewCell!
        
        // Setup cell
        listCell?.textLabel?.text = "\(ParseClient.sharedInstance().studentLocations[indexPath.row].firstName) \(ParseClient.sharedInstance().studentLocations[indexPath.row].lastName)"
        listCell?.detailTextLabel?.text = "\(ParseClient.sharedInstance().studentLocations[indexPath.row].mapString)"
        
        return listCell!
    }
    
    // TODO: Replace DetailVC with WebView
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let locationDetailsViewControler = storyboard?.instantiateViewController(withIdentifier: ParseClient.StoryBoardIdentifiers.locationDetailsController) as! LocationDetailsViewController
        locationDetailsViewControler.studentLocation = ParseClient.sharedInstance().studentLocations[indexPath.row]
        navigationController?.pushViewController(locationDetailsViewControler, animated: true)
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
