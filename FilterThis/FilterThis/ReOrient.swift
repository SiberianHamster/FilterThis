//
//  ReOrient.swift
//  FilterThis
//
//  Created by Mark Lin on 8/16/15.
//  Copyright (c) 2015 Mark Lin. All rights reserved.
//

import Foundation
import UIKit

class ReOrient {
  
  class func ImageGetOrientation(Image: UIImage)->UIImageOrientation{
    let orientation = Image.imageOrientation
    return orientation
  }
  
  class func ImageSetOrientation(Image: UIImage, orientation: UIImageOrientation) -> UIImage {
    var rotatedImage : UIImage
  
switch orientation {
  case .Down:
    rotatedImage = UIImage(CGImage: Image.CGImage, scale: 1.0, orientation: UIImageOrientation.Down)!
  case .Left:
    rotatedImage = UIImage(CGImage: Image.CGImage, scale: 1.0, orientation: UIImageOrientation.Left)!
  case .Right:
    rotatedImage = UIImage(CGImage: Image.CGImage, scale: 1.0, orientation: UIImageOrientation.Right)!
default:
  rotatedImage = Image
}
  return rotatedImage
}
}