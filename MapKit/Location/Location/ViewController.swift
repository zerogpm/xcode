//
//  ViewController.swift
//  Location
//
//  Created by Jian Su on 2016-06-15.
//  Copyright © 2016 ZeroTech. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
  
  @IBOutlet weak var updateLabel: UILabel!
  var locationManager : CLLocationManager?
  var startLocation: CLLocation?

  override func viewDidLoad() {
    super.viewDidLoad()
    
    locationManager = CLLocationManager()
    locationManager?.delegate = self
    locationManager?.desiredAccuracy = kCLLocationAccuracyBest
    locationManager?.requestWhenInUseAuthorization()
  }

}

extension ViewController: CLLocationManagerDelegate {
  
  func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    if startLocation == nil {
      startLocation = locations.first
    } else {
      guard let lastest = locations.first else {return}
      let distanceInMeters = startLocation?.distanceFromLocation(lastest)
      print("The distance is \(distanceInMeters)")
      if let up = distanceInMeters {
        updateLabel.text = String(up)
      }
    }
  }
  
  func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
    if status == .AuthorizedWhenInUse || status == .AuthorizedAlways {
      locationManager?.startUpdatingLocation()
    }
  }
}

