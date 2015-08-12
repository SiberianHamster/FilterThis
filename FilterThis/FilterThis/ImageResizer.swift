//
//  ImageResizer.swift
//  FilterThis
//
//  Created by Mark Lin on 8/12/15.
//  Copyright (c) 2015 Mark Lin. All rights reserved.
//

import UIKit

class ImageResizer {
  

  class func ImageResizer(image: UIImage)-> UIImage{
    UIGraphicsBeginImageContext(CGSize(width: 600, height: 600))
    image.drawInRect(CGRect(x: 0, y: 0, width: 600, height: 600))
    let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return resizedImage
  }
}
