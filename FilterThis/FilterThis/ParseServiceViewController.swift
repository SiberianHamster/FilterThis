//
//  ParseServiceViewController.swift
//  FilterThis
//
//  Created by Mark Lin on 8/16/15.
//  Copyright (c) 2015 Mark Lin. All rights reserved.
//

import UIKit
import Parse

class ParseServiceViewController: UIViewController {

  @IBOutlet weak var tableView: UITableView!
  
  var parseImages:[PFObject]=[]
  var parseObjectList:[String]=[]
  
    override func viewDidLoad() {
        super.viewDidLoad()
      self.tableView.dataSource = self
      
      ParseService.parseRetrieveListOfObjectID(
        {(data)-> (Void) in
          println("You got \(data.count) items")
        })
  
  }
}

extension ParseServiceViewController: UITableViewDataSource
{
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return parseObjectList.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell
//    cell.imageView?.image = ParseImages[indexPath.row].
    return cell
  }

}