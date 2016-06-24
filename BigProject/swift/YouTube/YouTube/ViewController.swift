//
//  ViewController.swift
//  YouTube
//
//  Created by Jian Su on 6/23/16.
//  Copyright © 2016 Jian Su. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationItem.title = "Home"
    
    collectionView?.backgroundColor = UIColor.whiteColor()
    collectionView?.registerClass(VideoCell.self, forCellWithReuseIdentifier: "cellId")
  }
  
  override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 5
  }
  
  override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cellId", forIndexPath: indexPath)
    return cell
  }

}

extension HomeController: UICollectionViewDelegateFlowLayout {
  
  func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
    return CGSizeMake(view.frame.width, 200)
  }
  
  func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
    return 0
  }
  
}


class VideoCell: UICollectionViewCell {
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViews()
  }
  
  let separatorView: UIView = {
    let view = UIView()
    view.backgroundColor = UIColor.blackColor()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  let thumbnailImageView:UIImageView = {
    let imageView = UIImageView()
    imageView.backgroundColor = UIColor.blueColor()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  func setupViews() {
    addSubview(thumbnailImageView)
    addSubview(separatorView)
    
    addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-16-[v0]-16-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0" : thumbnailImageView]))
    
    addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-16-[v0]-16-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0" : thumbnailImageView]))
    
    addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0" : separatorView]))
    
    addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[v0(1)]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0" : separatorView]))
    
    thumbnailImageView.frame = CGRectMake(0, 0, 100, 100)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  
}
