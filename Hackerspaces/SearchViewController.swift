//
//  SearchViewController.swift
//  Hackerspaces
//
//  Created by zephyz on 05/08/15.
//  Copyright (c) 2015 Fixme. All rights reserved.
//

import UIKit
import SwiftHTTP
import JSONJoy

let spaceAPI = "http://spaceapi.net/directory.json"

class SearchViewController: UIViewController {
    
    var refreshControl:UIRefreshControl!
    
    @IBOutlet weak var tableView: TableViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = tableView
        tableView.dataSource = tableView
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refreshControl.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(refreshControl)
    }
    

    //function that runs after pull to refresh.
    //Must call "endRefreshing" at some point
    func refresh(sender:AnyObject) {
        var request = HTTPTask()
        request.GET(spaceAPI, parameters: nil, completionHandler: {(response: HTTPResponse) in
            if let err = response.error {
                println("error: \(err.localizedDescription)")
            } else if let data = response.responseObject as? NSData {
                self.tableView.updateSpaceList(JSONDecoder(data).dictionary?.keys.array)
            }
            self.refreshControl.endRefreshing()

        })
    }
}
