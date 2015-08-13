//
//  ViewController.swift
//  FilterThis
//
//  Created by Mark Lin on 8/10/15.
//  Copyright (c) 2015 Mark Lin. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController {

  @IBOutlet weak var imageView: UIImageView!
  
  @IBOutlet weak var alertButton: UIButton!
  
  
  @IBOutlet weak var imageViewLeading: NSLayoutConstraint!
  
  @IBOutlet weak var imageViewTop: NSLayoutConstraint!
  
  @IBOutlet weak var imageViewTrailing: NSLayoutConstraint!
  
  @IBOutlet weak var imageViewBottom: NSLayoutConstraint!
  
  
  
  
  
  let picker: UIImagePickerController = UIImagePickerController()
  
  let alert = UIAlertController(title: "Options", message: "Here are all the option", preferredStyle: UIAlertControllerStyle.ActionSheet)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let testObject = PFObject(className: "TestObject")
    testObject["foo"] = "bar"
    testObject.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
      println("Object has been saved.")
    }
    
    
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
    
    let gaussianBlurAction = UIAlertAction(title: "Gaussian Blur", style: UIAlertActionStyle.Default) { (alert) -> Void in
      let image = CIImage(image: self.imageView.image!)
      let gaussianBlurFilter = CIFilter(name: "CIGaussianBlur")
      gaussianBlurFilter.setValue(image, forKey: kCIInputImageKey)
      gaussianBlurFilter.setValue(10, forKey: kCIInputRadiusKey)
      
      let outputImage = gaussianBlurFilter.outputImage
      let extent = outputImage.extent()
      let cgImage = gpuContext.createCGImage(outputImage, fromRect: extent)
      let finalImage = UIImage(CGImage: cgImage)
      self.imageView.image = finalImage
      
      
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
    
    
      
      if UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Phone{
        let filterAction = UIAlertAction(title: "FilterMe", style: UIAlertActionStyle.Default) { (alert) -> Void in
          enterFilterMode()
      }
      
      alert.addAction(filterAction)
    }
      
    let PostThisAction = UIAlertAction(title: "PostThis", style: UIAlertActionStyle.Default, handler: { (alert) -> Void in
      
      
      let post = PFObject(className: "Post")
      post["Text"] = "Test Post"
     
      if let image = self.imageView.image
      {
      let resizedImage = ImageResizer.ImageResizer(image)
      let newImage = resizedImage
      let data = UIImageJPEGRepresentation(newImage, 1.0)
      
        let file = PFFile(name: "post.jpeg",data: data)
        post["image"] = file
      }
      post.saveInBackgroundWithBlock({ (suceeded, error) -> Void in
        
      })
      
    })
      
      
    
    alert.addAction(cancelAction)
    alert.addAction(chooserAction)
    alert.addAction(sepiaAction)
    alert.addAction(gaussianBlurAction)
//    alert.addAction(DepthOfFieldAction)
    alert.addAction(GloomAction)
    alert.addAction(PostThisAction)
    
    
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

func enterFilterMode(){
  
  
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
