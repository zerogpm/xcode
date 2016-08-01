//
//  ViewController.swift
//  pokemonSurprise
//
//  Created by Jian Su on 2016-07-31.
//  Copyright © 2016 ZeroTech. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {
  
  @IBOutlet weak var mapView: MKMapView!
  
  let locationManager = CLLocationManager()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    mapView.delegate = self
    mapView.userTrackingMode = MKUserTrackingMode.Follow
  }
  
  override func viewDidAppear(animated: Bool) {
    locationAuthStatus()
  }
  
  func locationAuthStatus() {
    if CLLocationManager.authorizationStatus() == .AuthorizedWhenInUse {
      mapView.showsUserLocation = true
    } else {
      locationManager.requestWhenInUseAuthorization()
    }
  }
  
  @IBOutlet weak var spotRandomPokemon: UIButton!
  
}

extension ViewController: MKMapViewDelegate {
  
}
