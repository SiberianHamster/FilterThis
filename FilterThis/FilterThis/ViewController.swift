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
  
  @IBOutlet weak var collectionView: UICollectionView!
  
  
  var filters:[(originalImage:UIImage, CIContext)->(UIImage!)]=[
    FilterService.gaussianBlurAction,
    FilterService.gloomAction,
    FilterService.sepiaAction,
    FilterService.gaussianBlurAction,
    FilterService.gloomAction,
    FilterService.sepiaAction
  ]
  let context = CIContext(options: nil)
  var thumbnail : UIImage!
  
  var displayImage: UIImage? {
    didSet{
      thumbnail = ImageResizer.resizeImageWithSize(displayImage!, size: CGSizeMake(100, 100))
      self.imageView.image = displayImage
      collectionView.reloadData()
    }
  }
  
  
  let picker: UIImagePickerController = UIImagePickerController()
  
  let alert = UIAlertController(title: "Options", message: "Here are all the option", preferredStyle: UIAlertControllerStyle.ActionSheet)
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "GalleryCollection" {
      let GalleryCollection = segue.destinationViewController as! GalleryCollectionViewController
      
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    collectionView.delegate = self
    collectionView.dataSource = self
    weak var delegate: ImageSelectedDelegate?

    
    
    let testObject = PFObject(className: "TestObject")
    testObject["foo"] = "bar"
    testObject.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
      println("Object has been saved.")
      
    
    }
    
    
    // Do any additional setup after loading the view, typically from a nib.
    let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel) { (alert) -> Void in
    }
    
    let chooserAction = UIAlertAction(title: "Camera", style: UIAlertActionStyle.Default) { (alert) -> Void in
      self.presentViewController(self.picker, animated: true, completion: nil)
    }
    
    let GalleryAction = UIAlertAction(title: "Gallery", style: UIAlertActionStyle.Default) { (alert) -> Void in
      
      self.performSegueWithIdentifier("GalleryCollection", sender: nil)
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
        let resizedImage = ImageResizer.resizeImageWithSize(image, size: CGSizeMake(600, 600))
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
    alert.addAction(GalleryAction)
    
    
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
  
  
  func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
      let Orientation = ReOrient.ImageGetOrientation(imageView.image!)
    let filter = filters[indexPath.row]
    var filteredImage = filter(originalImage: imageView.image!,context)
    filteredImage = ReOrient.ImageSetOrientation(filteredImage, orientation: Orientation)
    imageView.image = filteredImage
  }
  
  
  
  
  
  func enterFilterMode(){
    imageViewTop.constant = 30
    imageViewLeading.constant = 30
    imageViewTrailing.constant = -30
    imageViewBottom.constant = 116
    collectionViewBottom.constant  = -50
    
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
    collectionViewBottom.constant  = -400
    
    UIView.animateWithDuration(0.3, animations: {() -> Void in
      self.view.layoutIfNeeded()
    })
    
    navigationItem.rightBarButtonItem=nil
    
  }
  
}

//Mark: ViewController Datasource
extension ViewController: UICollectionViewDataSource{
  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier("GalleryCell", forIndexPath: indexPath) as! ThumbnailCell
    let filter = filters[indexPath.row]
    
    if let thumbnail = thumbnail {
      
      let filteredImage = filter(originalImage: thumbnail,context)
      cell.imageView.image = filteredImage
      
    }
    return cell
  }
  
  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return filters.count
  }
}




//Mark: ViewController Delegates
extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate, UICollectionViewDelegate, ImageSelectedDelegate{
  func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
    let image: UIImage = (info[UIImagePickerControllerOriginalImage] as? UIImage)!
    self.displayImage = image
    self.picker.dismissViewControllerAnimated(true, completion: nil)
  }
  func controllerDidSelectImage(ImageSelected: UIImage) -> (Void){
    let image: UIImage = ImageSelected
    self.displayImage = image
  }
  
  func imagePickerControllerDidCancel(picker: UIImagePickerController) {
    self.picker.dismissViewControllerAnimated(true, completion: nil)
  }
}
