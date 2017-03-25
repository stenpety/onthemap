//
//  ListViewController.swift
//  OnTheMap
//
//  Created by Petr Stenin on 25/03/2017.
//  Copyright © 2017 Petr Stenin. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {
    
    var studentLocations = [StudentLocation]()
    @IBOutlet weak var studentLocationsTable: UITableView!
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        studentLocations = ParseClient.sharedInstance().studentLocations
        studentLocationsTable.reloadData()
        print("V will appear: ", studentLocations.count)
    }
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("Delegate: ", studentLocations.count)
        return studentLocations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Get cell type
        let listCell = tableView.dequeueReusableCell(withIdentifier: ParseClient.AuxConstants.listCellReuseIdentifier) as UITableViewCell!
        
        // Setup cell
        listCell?.textLabel?.text = "\(studentLocations[indexPath.row].firstName) \(ParseClient.sharedInstance().studentLocations[indexPath.row].lastName)"
        listCell?.detailTextLabel?.text = "\(studentLocations[indexPath.row].mapString)"
        
        print("Cell created")
        return listCell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO: bring LocationDetail VC and show details
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
