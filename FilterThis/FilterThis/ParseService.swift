//
//  ParseService.swift
//  FilterThis
//
//  Created by Mark Lin on 8/16/15.
//  Copyright (c) 2015 Mark Lin. All rights reserved.
//

import UIKit
import Parse

class ParseService {
  
  class func parseRetrieveListOfObjectID(completionHandler: (data:[String])->(Void))
  {
    var listOfObjects: [String]=[]
    var query = PFQuery(className:"Post")

    
    query.findObjectsInBackgroundWithBlock {
      (objects,error) -> Void in
      
      if error == nil {
        println("Successfully retrieved \(objects!.count) objectId.")

        if let objects = objects as? [PFObject] {
          for object in objects {
            listOfObjects.append(object.objectId!)
          }
          completionHandler(data: listOfObjects)
        }
      } else {

        println("Error: \(error!) \(error!.userInfo!)")
      }
    }

    //return listOfObjects
    }
  
}


      