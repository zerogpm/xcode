//
//  ViewController.swift
//  geoCoding
//
//  Created by Jian Su on 6/19/16.
//  Copyright © 2016 Jian Su. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
  
  @IBOutlet weak var ReverStackView: UIStackView!
  @IBOutlet weak var ReverseLong: UITextField!
  @IBOutlet weak var ReverseLat: UITextField!
  @IBOutlet weak var lookUpType: UISegmentedControl!
  @IBOutlet weak var results: UILabel!
  @IBOutlet weak var entry: UITextField!
  var geocoder: CLGeocoder?
  
  @IBAction func Segmented(sender: UISegmentedControl) {
    if sender.selectedSegmentIndex != 0 {
      ReverStackView.hidden = false
    } else {
      ReverStackView.hidden = true
    }
  }
  
  @IBAction func lookUpGeoCoding(sender: UIButton) {
    
    if geocoder == nil {
      geocoder = CLGeocoder()
    }
    
    if lookUpType.selectedSegmentIndex == 0 {
      // Address lookup
      
      geocoder?.geocodeAddressString(entry.text!) {
        [weak self]  placemarks, error in
        let placemarks = placemarks?.first
        guard let latitude = placemarks?.location?.coordinate.latitude else { print("no latitude"); return}
        guard let longitude = placemarks?.location?.coordinate.longitude else {print("no longtiude"); return}
        let coordinates = "\(latitude) \(longitude)"
        self?.results.text = coordinates
      }
      
    } else {
      guard let latitude = Double(ReverseLat.text!) else {print("no lat"); return}
      guard let longitude = Double(ReverseLong.text!) else {print ("no long"); return}
      
      let location = CLLocation(latitude: latitude, longitude: longitude)
      
      geocoder?.reverseGeocodeLocation(location) {
        [weak self] placemarks, error in
        let placemark = placemarks?.first
        guard let streetNumber = placemark?.subThoroughfare else {print("no street number"); return}
        guard let street = placemark?.thoroughfare else {print("no street"); return}
        guard let city = placemark?.locality else {print("no city"); return}
        guard let state = placemark?.administrativeArea else {print("state");return}
        
        let address = "\(street) \(streetNumber) \(street) \(city) \(state)"
        self?.results.text = address
      }
    }
    
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
}

