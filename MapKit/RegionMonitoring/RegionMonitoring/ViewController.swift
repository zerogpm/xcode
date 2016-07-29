//
//  ViewController.swift
//  RegionMonitoring
//
//  Created by Jian Su on 7/27/16.
//  Copyright © 2016 Jian Su. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
  
  var locationManager = CLLocationManager()
  var monitoringLocation: CLLocation?

  override func viewDidLoad() {
    super.viewDidLoad()
    
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
    locationManager.delegate = self
    monitoringLocation = CLLocation(latitude: 37.331600000000002, longitude: -122.0301)
    locationManager.requestAlwaysAuthorization()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

extension ViewController: CLLocationManagerDelegate {
  
  func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
    if status == .AuthorizedAlways {
      if CLLocationManager.isMonitoringAvailableForClass(CLCircularRegion) {
        let region = CLCircularRegion(center: (monitoringLocation?.coordinate)!, radius: 300, identifier: "Apple HQ")
        region.notifyOnEntry = true
        region.notifyOnExit = true
        locationManager.startMonitoringForRegion(region)
      }
      
      for region in locationManager.monitoredRegions {
        print(region.identifier)
      }
      locationManager.startUpdatingLocation()
    }
  }
  
  func locationManager(manager: CLLocationManager, didEnterRegion region: CLRegion) {
    print("entered region")
  }
  
  func locationManager(manager: CLLocationManager, didExitRegion region: CLRegion) {
    print("exited region")
  }
  
  func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
    print(error)
  }
  
  func locationManager(manager: CLLocationManager, monitoringDidFailForRegion region: CLRegion?, withError error: NSError) {
    print("region error")
  }
  
}

