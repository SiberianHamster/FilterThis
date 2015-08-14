//
//  ImageResizer.swift
//  FilterThis
//
//  Created by Mark Lin on 8/12/15.
//  Copyright (c) 2015 Mark Lin. All rights reserved.
//

import UIKit

class ImageResizer {
  
  class func resizeImageWithSize(image: UIImage, size:CGSize) ->UIImage
  {
  UIGraphicsBeginImageContext(size)
    image.drawInRect(CGRectMake(0, 0, size.width, size.height))
    let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return resizedImage
  }
}
