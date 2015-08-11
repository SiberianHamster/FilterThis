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
    
    let sepiaAction = UIAlertAction(title: "Sepia", style: UIAlertActionStyle.Default) { (alert) -> Void in
      println("apply sepia")
    }
    
    let DepthOfFieldAction = UIAlertAction(title: "Depth Of Field", style: UIAlertActionStyle.Default){(alert) -> Void in
      println("appy depth of field")
    }
    
    let GloomAction = UIAlertAction(title: "Gloom", style:  UIAlertActionStyle.Default) { (alert) -> Void in
      println("apply gloom")
    }
    
    alert.addAction(cancelAction)
    alert.addAction(chooserAction)
    alert.addAction(sepiaAction)
    alert.addAction(DepthOfFieldAction)
    alert.addAction(GloomAction)
    
    
    self.picker.delegate = self
    self.picker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
    
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
