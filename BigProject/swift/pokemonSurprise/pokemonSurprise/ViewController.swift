//
//  ViewController.swift
//  pokemonSurprise
//
//  Created by Jian Su on 2016-07-31.
//  Copyright © 2016 ZeroTech. All rights reserved.
//

import UIKit
import MapKit
import FirebaseDatabase

class ViewController: UIViewController {
  
  @IBOutlet weak var mapView: MKMapView!
  
  let locationManager = CLLocationManager()
  var mapHasCenteredOnce = false
  var geoFire:GeoFire!
  var geoFireRef: FIRDatabaseReference!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    mapView.delegate = self
    mapView.userTrackingMode = MKUserTrackingMode.Follow
    
    //geoFireRef = FIRDatabase.database().reference()
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
  
  func createSignting(location:CLLocation, pokeid:Int) {
    //make network request for  saving pokeMon
    // pass location and pokemon id for  saving query database
  }
  
  func showSightingsOnMap(location:CLLocation) {
    //make network request
    //passing in location and Radius
    let anno = PokeAnnotation(coordinate: location.coordinate, pokemonNumber: Int(1), pokemonName: "PikaChu")
    self.mapView.addAnnotation(anno)
  }
  
 
  @IBAction func spotRandomPokemon(sender: UIButton) {
    let loc = CLLocation(latitude: mapView.centerCoordinate.latitude, longitude: mapView.centerCoordinate.longitude)
    createSignting(loc, pokeid: 1)
  }
  
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
    
    let annoIdentifier = "Pokemon"
    var annotationView: MKAnnotationView?
    
    if annotation.isKindOfClass(MKUserLocation.self) {
      annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "User")
      annotationView?.image = UIImage(named: "ash")
    } else if let deqAnno = mapView.dequeueReusableAnnotationViewWithIdentifier(annoIdentifier) {
      annotationView = deqAnno
      annotationView?.annotation = annotation
    } else {
      let av = MKAnnotationView(annotation: annotation, reuseIdentifier: annoIdentifier)
      av.rightCalloutAccessoryView = UIButton(type: .DetailDisclosure)
      annotationView = av
    }
    
    if let annotationView = annotationView, let anno = annotation as? PokeAnnotation {
      
      annotationView.canShowCallout = true
      annotationView.image = UIImage(named:"\(anno.pokemonNumber)")
      let btn = UIButton()
      btn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
      btn.setImage(UIImage(named:"map"), forState: .Normal)
      annotationView.rightCalloutAccessoryView = btn
    }
    
    return annotationView
  }
  
  func mapView(mapView: MKMapView, regionWillChangeAnimated animated: Bool) {
    let loc = CLLocation(latitude: mapView.centerCoordinate.latitude, longitude: mapView.centerCoordinate.longitude)
    showSightingsOnMap(loc)
  }
  
  func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
    if let anno = view.annotation as? PokeAnnotation {
      
    }
  }
}

extension ViewController: CLLocationManagerDelegate {
  
  func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
    if status == CLAuthorizationStatus.AuthorizedWhenInUse {
      mapView.showsUserLocation = true
    }
  }
  
}
