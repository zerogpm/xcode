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
    return view
  }()
  
  let userProfileImageView:UIImageView = {
    let imageView = UIImageView()
    imageView.backgroundColor = UIColor.greenColor()
    return imageView
  }()
  
  let thumbnailImageView:UIImageView = {
    let imageView = UIImageView()
    imageView.backgroundColor = UIColor.blueColor()
    return imageView
  }()
  
  func setupViews() {
    addSubview(thumbnailImageView)
    addSubview(separatorView)
    addSubview(userProfileImageView)
    
    addConstraintsWithFormat("H:|-16-[v0]-16-|", views: thumbnailImageView)
    
    addConstraintsWithFormat("H:|-16-[v0(44)]", views: userProfileImageView)
    
    //vertical constraints
    addConstraintsWithFormat("V:|-16-[v0]-8-[v1(44)]-16-[v2(1)]|", views: thumbnailImageView, userProfileImageView, separatorView)
    
    addConstraintsWithFormat("H:|[v0]|", views: separatorView)
    
    thumbnailImageView.frame = CGRectMake(0, 0, 100, 100)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}

extension UIView {
  
  func addConstraintsWithFormat(format:String, views:UIView...) {
    
    var viewsDictionary = [String:UIView]()
    for (index, view) in views.enumerate() {
      let key = "v\(index)"
      view.translatesAutoresizingMaskIntoConstraints = false
      viewsDictionary[key] = view
    }
    
    addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
  }
}
