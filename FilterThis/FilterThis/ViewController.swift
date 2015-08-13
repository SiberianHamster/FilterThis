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
  
  @IBOutlet weak var collectionViewBottom: NSLayoutConstraint!
  
  
  
  
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

    
    
        

      if UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Phone{
        let filterAction = UIAlertAction(title: "FilterMe", style: UIAlertActionStyle.Default) { (alert) -> Void in
          self.enterFilterMode()
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
  
  func enterFilterMode(){
  imageViewTop.constant = 30
  imageViewLeading.constant = 30
  imageViewTrailing.constant = -30
  imageViewBottom.constant = 116
  collectionViewBottom.constant  = 8
  
  UIView.animateWithDuration(0.3, animations: { () -> Void in
    self.view.layoutIfNeeded()
  })
  let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Done, target: self, action: "closeFilterMode")
  navigationItem.rightBarButtonItem=doneButton
}
func closeFilterMode(){
  
  imageViewTop.constant = 8
  imageViewLeading.constant = 0
  imageViewTrailing.constant = 0
  imageViewBottom.constant = 8
  collectionViewBottom.constant  = -200
  
  UIView.animateWithDuration(0.3, animations: {() -> Void in
    self.view.layoutIfNeeded()
  })
  
  navigationItem.rightBarButtonItem=nil
  
}

}

//Mark: ViewController Datasource
extension ViewController: UICollectionViewDataSource{
  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let availableFilters = collectionView.dequeueReusableCellWithReuseIdentifier("filterCells", forIndexPath: indexPath) as! UICollectionViewCell
    
    
    
    return availableFilters
  }
  
  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 22
  }
}


//Mark: ViewController Delegates
extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate, UICollectionViewDelegate{
  func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
    let image: UIImage = (info[UIImagePickerControllerOriginalImage] as? UIImage)!
    self.imageView.image = image
    self.picker.dismissViewControllerAnimated(true, completion: nil)
  }
  
  func imagePickerControllerDidCancel(picker: UIImagePickerController) {
    self.picker.dismissViewControllerAnimated(true, completion: nil)
  }
  
  
}
