//
//  ViewController.swift
//  FilterThis
//
//  Created by Mark Lin on 8/10/15.
//  Copyright (c) 2015 Mark Lin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var imageView: UIImageView!
  
  @IBOutlet weak var alertButton: UIButton!
  
  let picker: UIImagePickerController = UIImagePickerController()
  
  let alert = UIAlertController(title: "Options", message: "Here are all the option", preferredStyle: UIAlertControllerStyle.ActionSheet)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel) { (alert) -> Void in
    }
    
    let chooserAction = UIAlertAction(title: "Choose", style: UIAlertActionStyle.Default) { (alert) -> Void in
      self.presentViewController(self.picker, animated: true, completion: nil)
    }
      let options = [kCIContextWorkingColorSpace: NSNull()]
      let eaglContext = EAGLContext(API: EAGLRenderingAPI.OpenGLES2)
      let gpuContext = CIContext(EAGLContext: eaglContext, options: options)
    
    
    let sepiaAction = UIAlertAction(title: "Sepia", style: UIAlertActionStyle.Default) { (alert) -> Void in
      let image = CIImage(image: self.imageView.image!)
      let sepiaFilter = CIFilter(name: "CISepiaTone")
      sepiaFilter.setValue(image, forKey: kCIInputImageKey)
      sepiaFilter.setValue(1, forKey: kCIInputIntensityKey)
      
      let outputImage = sepiaFilter.outputImage
      let extent = outputImage.extent()
      let cgImage = gpuContext.createCGImage(outputImage, fromRect: extent)
      let finalImage = UIImage(CGImage: cgImage)
      self.imageView.image = finalImage
    }
    
    let DepthOfFieldAction = UIAlertAction(title: "Depth Of Field", style: UIAlertActionStyle.Default){(alert) -> Void in
      println("appy depth of field")
//      let imageInputPoint1 = CGVectorMake(100, 100)
//      let imageInputPoint2 = CGVectorMake(300, 300)
      let image = CIImage(image: self.imageView.image!)
//      let vector = CIVector(x: <#CGFloat#>, y: <#CGFloat#>)
      let DepthOfFieldFilter = CIFilter(name: "CIDepthOfField", withInputParameters:["inputImage":image]["inputPoint1":imageInputPoint1]["inputPoint2":imageInputPoint2] ["inputSaturation":10]["inputUnsharpMaskRadius":100]["inputUnsharpMaskIntensity":1]["inputRadius":10])
      
      let outputImage = DepthOfFieldFilter.outputImage
      let extent = outputImage.extent()
      let cgImage = gpuContext.createCGImage(outputImage, fromRect: extent)
      let finalImage = UIImage(CGImage: cgImage)
      self.imageView.image = finalImage
      
    }
    
    let GloomAction = UIAlertAction(title: "Gloom", style:  UIAlertActionStyle.Default) { (alert) -> Void in
      let image = CIImage(image: self.imageView.image!)
      let gloomFilter = CIFilter(name: "CIGloom")
      gloomFilter.setValue(image, forKey: kCIInputImageKey)
      gloomFilter.setValue(10, forKey: kCIInputRadiusKey)
      gloomFilter.setValue(1, forKey: kCIInputIntensityKey)
      
      let outputImage = gloomFilter.outputImage
      let extent = outputImage.extent()
      let cgImage = gpuContext.createCGImage(outputImage, fromRect: extent)
      let finalImage = UIImage(CGImage: cgImage)
      self.imageView.image = finalImage
      
      
      
    }
    
    alert.addAction(cancelAction)
    alert.addAction(chooserAction)
    alert.addAction(sepiaAction)
    alert.addAction(DepthOfFieldAction)
    alert.addAction(GloomAction)
    
    
    picker.delegate = self
    if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera){picker.sourceType = UIImagePickerControllerSourceType.Camera
      }
    else {picker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary}
    
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  @IBAction func buttonTapped(sender: UIButton) {
    alert.modalPresentationStyle = UIModalPresentationStyle.Popover
    
    if let popover = alert.popoverPresentationController{
      popover.sourceView = view
      popover.sourceRect = alertButton.frame
    }
    self.presentViewController(alert, animated: true, completion: nil)
  }

}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
  func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
    let image: UIImage = (info[UIImagePickerControllerOriginalImage] as? UIImage)!
    self.imageView.image = image
    self.picker.dismissViewControllerAnimated(true, completion: nil)
  }
  
  func imagePickerControllerDidCancel(picker: UIImagePickerController) {
    self.picker.dismissViewControllerAnimated(true, completion: nil)
  }
  
  
}
