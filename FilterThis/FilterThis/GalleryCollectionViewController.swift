//
//  GalleryCollectionViewController.swift
//  FilterThis
//
//  Created by Mark Lin on 8/14/15.
//  Copyright (c) 2015 Mark Lin. All rights reserved.
//

import UIKit
import Photos

protocol ImageSelectedDelegate : class{
  func controllerDidSelectImage(UIImage) -> (Void)
}

class GalleryCollectionViewController: UIViewController {

  @IBOutlet weak var collectionView: UICollectionView!
  
  var fetchResult : PHFetchResult!
  var cellsize = CGSize(width: 100, height: 100)
  var desiredFinalImageSize = CGSize(width: 100, height: 100)
  var startingScale : CGFloat = 0
  var scale : CGFloat = 0
  
  weak var delegate: ImageSelectedDelegate?
  
    override func viewDidLoad() {
        super.viewDidLoad()
      collectionView.dataSource = self
      collectionView.delegate = self
      
      fetchResult = PHAsset.fetchAssetsWithMediaType(PHAssetMediaType.Image, options: nil)
      
      let pinchGesture = UIPinchGestureRecognizer(target: self, action: "pinchRecognized:")
      collectionView.addGestureRecognizer(pinchGesture)

    }
  
  func pinchRecognized(pinch : UIPinchGestureRecognizer) {
    
    if pinch.state == UIGestureRecognizerState.Began {
      startingScale = pinch.scale
    }
    
    if pinch.state == UIGestureRecognizerState.Changed {
    }
    
    if pinch.state == UIGestureRecognizerState.Ended {
      scale = startingScale * pinch.scale
      let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
      let newSize = CGSize(width: layout.itemSize.width * scale, height: layout.itemSize.height * scale)
      
      collectionView.performBatchUpdates({ () -> Void in
        layout.itemSize = newSize
        layout.invalidateLayout()
        }, completion: nil )
      
    }
  }

  
  
  
}

//Mark: GalleryCollectionView DataSource
extension GalleryCollectionViewController: UICollectionViewDataSource
{
  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return fetchResult.count
  }
  
  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier("GalleryCell", forIndexPath: indexPath) as! ThumbnailCell
    
    if let asset = fetchResult[indexPath.row] as? PHAsset {
      PHCachingImageManager.defaultManager().requestImageForAsset(asset, targetSize: cellsize, contentMode: PHImageContentMode.AspectFill, options: nil) { (image, info) -> Void in
        
        if let image = image
        {
          println("hi")
          cell.imageView?.image = image
        }
      }
    }
    
    return cell
  }
  
}

//Mark: GalleryCollectionView Delegate

extension GalleryCollectionViewController : UICollectionViewDelegate{
  func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    
      let options = PHImageRequestOptions()
    options.synchronous = true
    
    if let asset = fetchResult[indexPath.row] as? PHAsset {
      PHCachingImageManager.defaultManager().requestImageForAsset(asset, targetSize: desiredFinalImageSize, contentMode: PHImageContentMode.AspectFill, options: options) { (image, info) -> Void in
        
        if let image = image {
          self.delegate?.controllerDidSelectImage(image)
//          self.navigationController?.viewControllers
//          good old way to find out all the viewcontrollers of navigationController.
          self.navigationController?.popViewControllerAnimated(true)
        }
      }
    }
  }
}

