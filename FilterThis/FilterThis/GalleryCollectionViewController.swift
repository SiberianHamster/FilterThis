//
//  GalleryCollectionViewController.swift
//  FilterThis
//
//  Created by Mark Lin on 8/14/15.
//  Copyright (c) 2015 Mark Lin. All rights reserved.
//

import UIKit

class GalleryCollectionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

extension GalleryCollectionViewController: UICollectionViewDataSource
{
  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    var cell = collectionView.dequeueReusableCellWithReuseIdentifier("GalleryCell", forIndexPath: indexPath) as! UICollectionViewCell
    return cell
  }
  
  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 1
  }
}
  

