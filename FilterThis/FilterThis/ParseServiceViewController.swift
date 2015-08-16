//
//  ParseServiceViewController.swift
//  FilterThis
//
//  Created by Mark Lin on 8/16/15.
//  Copyright (c) 2015 Mark Lin. All rights reserved.
//

import UIKit

class ParseServiceViewController: UIViewController {

  @IBOutlet weak var tableView: UITableView!
  
    override func viewDidLoad() {
        super.viewDidLoad()
      self.tableView.dataSource = self

    }
  

}

extension ParseServiceViewController: UITableViewDataSource
{
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell
    return cell
  }

}