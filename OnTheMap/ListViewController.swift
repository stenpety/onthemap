//
//  ListViewController.swift
//  OnTheMap
//
//  Created by Petr Stenin on 25/03/2017.
//  Copyright © 2017 Petr Stenin. All rights reserved.
//

import UIKit

class ListViewController: UITableViewController {
    
    var studentLocations = [StudentLocation]()
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        studentLocations = ParseClient.sharedInstance().studentLocations
        tableView.reloadData()
    }
    
    // MARK: TableView Delegate & Data Source functions
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studentLocations.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Get cell type
        let listCell = tableView.dequeueReusableCell(withIdentifier: ParseClient.StoryBoardIdentifiers.listCellReuseIdentifier) as UITableViewCell!
        
        // Setup cell
        listCell?.textLabel?.text = "\(studentLocations[indexPath.row].firstName) \(ParseClient.sharedInstance().studentLocations[indexPath.row].lastName)"
        listCell?.detailTextLabel?.text = "\(studentLocations[indexPath.row].mapString)"
        
        return listCell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let locationDetailsViewControler = storyboard?.instantiateViewController(withIdentifier: ParseClient.StoryBoardIdentifiers.locationDetailsController) as! LocationDetailsViewController
        locationDetailsViewControler.studentLocation = studentLocations[indexPath.row]
        navigationController?.pushViewController(locationDetailsViewControler, animated: true)
        //self.present(locationDetailsViewControler, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    // MARK: TableViewVC singleton shared instance
    class func sharedInstance () -> ListViewController {
        struct Singleton {
            static let sharedInstance = ListViewController()
        }
        return Singleton.sharedInstance
    }
}
