//
//  ViewController.swift
//  MkMapKit
//
//  Created by Jian Su on 7/29/16.
//  Copyright © 2016 Jian Su. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {

  @IBOutlet weak var map: MKMapView!
  let locationManager = CLLocationManager()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let myHouse = CLLocation(latitude: 49.2284395, longitude: -122.9336268)
    let regionRadius: CLLocationDistance = 1000.0
    let region = MKCoordinateRegionMakeWithDistance(myHouse.coordinate, regionRadius, regionRadius)
    map.setRegion(region, animated: true)
    
    map.delegate = self
    locationManager.delegate = self
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
    locationManager.requestWhenInUseAuthorization()
    
  }
}

extension ViewController: CLLocationManagerDelegate {
  
}

extension ViewController: MKMapViewDelegate {
  
  func mapViewWillStartLoadingMap(mapView: MKMapView) {
    print("rendering......")
  }
  
}

