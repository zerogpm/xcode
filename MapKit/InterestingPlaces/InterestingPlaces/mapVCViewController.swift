//
//  mapVCViewController.swift
//  InterestingPlaces
//
//  Created by Jian Su on 2016-07-30.
//  Copyright © 2016 Razeware LLC. All rights reserved.
//

import UIKit
import MapKit

class mapVCViewController: UIViewController {
  @IBOutlet weak var map: MKMapView!
  
  let locationManager = CLLocationManager()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let appleHQ = CLLocation(latitude: 37.331177, longitude: -122.031641)
    let regionRadius: CLLocationDistance = 1000.0
    let region = MKCoordinateRegionMakeWithDistance(appleHQ.coordinate, regionRadius, regionRadius)
    map.setRegion(region, animated: true)
    map.delegate = self
    
    locationManager.delegate = self
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
    locationManager.requestWhenInUseAuthorization()
  }
  
  @IBAction func dissMiss(sender: AnyObject) {
    self.dismissViewControllerAnimated(true, completion: nil)
  }
  
  
}

extension mapVCViewController: CLLocationManagerDelegate {
  
}

extension mapVCViewController: MKMapViewDelegate {
  
  
  
}