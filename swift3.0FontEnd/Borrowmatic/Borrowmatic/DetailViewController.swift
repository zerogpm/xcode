//
//  DetailViewController.swift
//  Borrowmatic
//
//  Created by Jian Su on 2017-03-28.
//  Copyright © 2017 ZeroTech. All rights reserved.
//

import UIKit
import CoreData

class DetailViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
  @IBOutlet weak var itemTitleText: UITextField!
  @IBOutlet weak var itemImageView: UIImageView!
  @IBOutlet weak var borrowedAtLabel: UILabel!
  @IBOutlet weak var returnAtLabel: UILabel!
  @IBOutlet weak var personImageView: UIImageView!
  @IBOutlet weak var personTextField: UITextField!
  
  var moc:NSManagedObjectContext!
  
  var detailItem: BorrowItem? {
    didSet {
      // Update the view.
      self.configureView()
    }
  }
  
  var personImageAdded = false
  var itemImageAdded = false
  
  enum PicturePurpose {
    case item
    case person
  }
  
  var picturePurposeSelector:PicturePurpose = .item
  
  func configureView() {
    
    if let titleTextField = itemTitleText {
      if let borrowItem = detailItem {
        titleTextField.text = borrowItem.title
        
        if let availableImageDate = borrowItem.image as? Data {
            itemImageView.image = UIImage(data: availableImageDate)
        }
        
      }
    }
    
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    moc = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let itemGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(DetailViewController.addPictureForItem))
    itemImageView.addGestureRecognizer(itemGestureRecognizer)
    
    let personGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(DetailViewController.addPictureForPerson))
    personImageView.addGestureRecognizer(personGestureRecognizer)
    
    self.configureView()
  }
  
  @IBAction func saveItem(_ sender: UIBarButtonItem) {
    
    if detailItem == nil { //create a new Borrow It
      
      let borrowItem = BorrowItem(context: moc)
      borrowItem.title = itemTitleText.text
      
      if let itemimage = itemImageView.image {
        borrowItem.image = NSData(data:UIImageJPEGRepresentation(itemimage, 0.3)!)
      }
      
    } // update an exisiting item
    
    do {
      try moc.save()
    } catch {
      print(error.localizedDescription)
    }
    
  }
  
  func addPictureForItem() {
    picturePurposeSelector = .item
    addImageWithPurpose()
  }
  
  func addPictureForPerson() {
    picturePurposeSelector = .person
    addImageWithPurpose()
  }
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
      
      // scaled Image
      let scaledImage = UIImage.scaleImage(image: image, toWidth: 120, andHeight: 120)
      
      if picturePurposeSelector == .item {
        itemImageView.image = scaledImage
        itemImageAdded = true
      } else {
        personImageView.image = scaledImage
        personImageAdded = true
      }
    }
    
    picker.dismiss(animated: true, completion: nil)
  }
  
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    picker.dismiss(animated: true, completion: nil)
  }
  
  func addImageWithPurpose() {
    let imagePickerVC = UIImagePickerController()
    imagePickerVC.delegate = self
    imagePickerVC.sourceType = .photoLibrary
    self.present(imagePickerVC, animated: true, completion: nil)
  }
  
}

