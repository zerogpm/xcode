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
  var mapHasCenteredOnce = false
  
  override func viewDidLoad() {
    super.viewDidLoad()
    mapView.delegate = self
    mapView.userTrackingMode = MKUserTrackingMode.Follow
  }
  
  override func viewDidAppear(animated: Bool) {
    locationAuthStatus()
  }
  
  func centerMapOnlocation(location:CLLocation) {
    let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, 2000, 2000)
    
    mapView.setRegion(coordinateRegion, animated: true)
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
  func mapView(mapView: MKMapView, didUpdateUserLocation userLocation: MKUserLocation) {
    if let loc = userLocation.location {
      if !mapHasCenteredOnce {
        centerMapOnlocation(loc)
        mapHasCenteredOnce = true
      }
    }
  }
  
  func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
    
    var annotationView: MKAnnotationView?
    
    if annotation.isKindOfClass(MKUserLocation.self) {
      annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "User")
      annotationView?.image = UIImage(named: "ash")
    }
    
    return annotationView
  }
}

extension ViewController: CLLocationManagerDelegate {
  
  func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
    if status == CLAuthorizationStatus.AuthorizedWhenInUse {
      mapView.showsUserLocation = true
    }
  }
  
}
