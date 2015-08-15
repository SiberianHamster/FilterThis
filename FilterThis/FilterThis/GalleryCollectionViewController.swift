//
//  GalleryCollectionViewController.swift
//  FilterThis
//
//  Created by Mark Lin on 8/14/15.
//  Copyright (c) 2015 Mark Lin. All rights reserved.
//

import UIKit
import Photos

class GalleryCollectionViewController: UIViewController {

  @IBOutlet weak var collectionView: UICollectionView!
  
  var fetchResult : PHFetchResult!
  var cellsize = CGSize(width: 100, height: 100)
  
    override func viewDidLoad() {
        super.viewDidLoad()
      
      
      fetchResult = PHAsset.fetchAssetsWithMediaType(PHAssetMediaType.Image, options: nil)

    }
}

//Mark: GalleryCollectionView DataSource
extension GalleryCollectionViewController: UICollectionViewDataSource
{
  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 12
  }
  
  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier("GalleryCell", forIndexPath: indexPath) as! UICollectionViewCell
    
    return cell
  }
  
}