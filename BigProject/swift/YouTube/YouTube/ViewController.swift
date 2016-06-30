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
    return CGSizeMake(view.frame.width, 300)
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
  
  let subtitleTextView: UITextView = {
    let textView = UITextView()
    textView.translatesAutoresizingMaskIntoConstraints = false
    textView.text = "TaylorSwiftVEVO • 1,604,684,607 views • 2 years ago"
    textView.textContainerInset = UIEdgeInsetsMake(0, -4, 0, 0)
    textView.textColor = UIColor.lightGrayColor()
    return textView
  }()
  
  let userProfileImageView:UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(named: "taylor_swift_profile")
    imageView.layer.cornerRadius = 22
    imageView.layer.masksToBounds = true
    return imageView
  }()
  
  let thumbnailImageView:UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(named: "taylor_swift_blank_space")
    imageView.contentMode = .ScaleAspectFill
    imageView.clipsToBounds = true
    return imageView
  }()
  
  let titleLabel:UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "Taylor Swift - Blank Space"
    return label
  }()
  
  func setupViews() {
    addSubview(thumbnailImageView)
    addSubview(separatorView)
    addSubview(userProfileImageView)
    addSubview(titleLabel)
    addSubview(subtitleTextView)
    
    addConstraintsWithFormat("H:|-16-[v0]-16-|", views: thumbnailImageView)
    
    addConstraintsWithFormat("H:|-16-[v0(44)]", views: userProfileImageView)
    
    //vertical constraints
    addConstraintsWithFormat("V:|-16-[v0]-8-[v1(44)]-16-[v2(1)]|", views: thumbnailImageView, userProfileImageView, separatorView)
    
    addConstraintsWithFormat("H:|[v0]|", views: separatorView)
    
    thumbnailImageView.frame = CGRectMake(0, 0, 100, 100)
    
    //top constraint
    addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .Top, relatedBy: .Equal, toItem: thumbnailImageView, attribute: .Bottom, multiplier: 1, constant: 8))
    
    //left constraint
    addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .Left, relatedBy: .Equal, toItem: userProfileImageView, attribute: .Right, multiplier: 1, constant: 8))
    
    //right constraint
    addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .Right, relatedBy: .Equal, toItem: thumbnailImageView, attribute: .Right, multiplier: 1, constant: 0))
    
    //height constraint
    addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .Height, relatedBy: .Equal, toItem: self  , attribute: .Height, multiplier: 0, constant: 20))
    
    
    ///
    //top constraint
    addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .Top, relatedBy: .Equal, toItem: titleLabel, attribute: .Bottom, multiplier: 1, constant: 4))
    
    //left constraint
    addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .Left, relatedBy: .Equal, toItem: userProfileImageView, attribute: .Right, multiplier: 1, constant: 8))
    
    //right constraint
    addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .Right, relatedBy: .Equal, toItem: thumbnailImageView, attribute: .Right, multiplier: 1, constant: 0))
    
    //height constraint
    addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .Height, relatedBy: .Equal, toItem: self, attribute: .Height, multiplier: 0, constant: 30))
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
