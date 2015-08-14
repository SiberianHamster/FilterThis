//
//  FilterService.swift
//  FilterThis
//
//  Created by Mark Lin on 8/13/15.
//  Copyright (c) 2015 Mark Lin. All rights reserved.
//

import UIKit

class FilterService{
  
  
  
  
  class func sepiaAction(originalImage:UIImage, context: CIContext)->UIImage  {

    let image = CIImage(image: originalImage)
    let sepiaFilter = CIFilter(name: "CISepiaTone")
    sepiaFilter.setValue(image, forKey: kCIInputImageKey)
    sepiaFilter.setValue(1, forKey: kCIInputIntensityKey)
    return filteredImageFromFilter(sepiaFilter, context: context)
  }
  

  class func gaussianBlurAction(originalImage: UIImage, context: CIContext) -> UIImage {

    let image = CIImage(image: originalImage)
    let gaussianBlurFilter = CIFilter(name: "CIGaussianBlur")
    gaussianBlurFilter.setValue(image, forKey: kCIInputImageKey)
    gaussianBlurFilter.setValue(10, forKey: kCIInputRadiusKey)
    return filteredImageFromFilter(gaussianBlurFilter, context: context)
  }

  
  //    let DepthOfFieldAction = UIAlertAction(title: "Depth Of Field", style: UIAlertActionStyle.Default){(alert) -> Void in
  //      println("appy depth of field")
  //      let imageInputPoint1 = CIVector(x: 100, y: 100)
  //      let imageInputPoint2 = CIVector(x: 200, y: 200)
  //      let image = CIImage(image: self.imageView.image!)
  //      let depthOfFieldFilterDictionary = ["inputImage":image, "inputPoint1":imageInputPoint1, "inputPoint2":imageInputPoint2, "inputSaturation":10, "inputUnsharpMaskRadius":100, "inputUnsharpMaskIntensity":1, "inputRadius":10]
  //      let DepthOfFieldFilter = CIFilter(name: "CIDepthOfField", withInputParameters:depthOfFieldFilterDictionary)
  //
  //      let outputImage = DepthOfFieldFilter.outputImage
  //      let extent = outputImage.extent()
  //      let cgImage = gpuContext.createCGImage(outputImage, fromRect: extent)
  //      let finalImage = UIImage(CGImage: cgImage)
  //      self.imageView.image = finalImage
  
  //    }

    
    class func gloomAction(originalImage: UIImage, context: CIContext) -> UIImage{
      let image = CIImage(image: originalImage)
      let gloomFilter = CIFilter(name: "CIGloom")
      gloomFilter.setValue(image, forKey: kCIInputImageKey)
      gloomFilter.setValue(10, forKey: kCIInputRadiusKey)
      gloomFilter.setValue(1, forKey: kCIInputIntensityKey)
      return filteredImageFromFilter(gloomFilter, context: context)
    }
    
  class func filteredImageFromFilter(filter: CIFilter, context : CIContext)->UIImage{
      let outputImage = filter.outputImage
      let extent = outputImage.extent()
      let cgImage = context.createCGImage(outputImage, fromRect: extent)
      let finalImage = UIImage(CGImage: cgImage)!
      return finalImage
    }
  }

