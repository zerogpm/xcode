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
  var places: [OldPlace] = []
  var selectedPlace: OldPlace?
  
  let locationManager = CLLocationManager()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let regionRadius: CLLocationDistance = 500
    
    if let selectedPlace = selectedPlace {
      let coordinateRegion = MKCoordinateRegionMakeWithDistance(selectedPlace.location.coordinate, regionRadius, regionRadius)
      map.setRegion(coordinateRegion, animated: true)
    }
    
    map.delegate = self
    map.mapType = .Standard
    map.rotateEnabled = false
    map.addAnnotations(places)
    produceOverlay()
    
    locationManager.delegate = self
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
    locationManager.requestWhenInUseAuthorization()
  }
  
  @IBAction func dissMiss(sender: AnyObject) {
    self.dismissViewControllerAnimated(true, completion: nil)
  }
  
  func produceOverlay() {
    var points: [CLLocationCoordinate2D] = []
    points.append(CLLocationCoordinate2DMake(40.063965, -82.346642))
    points.append(CLLocationCoordinate2DMake(40.063971, -82.346057))
    points.append(CLLocationCoordinate2DMake(40.063957, -82.346030))
    points.append(CLLocationCoordinate2DMake(40.063602, -82.346018))
    points.append(CLLocationCoordinate2DMake(40.063561, -82.346057))
    points.append(CLLocationCoordinate2DMake(40.063561, -82.346800))
    points.append(CLLocationCoordinate2DMake(40.063965, -82.346800))
    let polygon = MKPolygon(coordinates: &points, count: points.count)
    map.addOverlay(polygon)
  }
  
}

extension mapVCViewController: CLLocationManagerDelegate {
  
}

extension mapVCViewController: MKMapViewDelegate {
  
  func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
    
    if annotation is MKUserLocation {
      return nil
    }
    
    var annotationView = map.dequeueReusableAnnotationViewWithIdentifier("interestingPlace") as? MKPinAnnotationView
    if annotationView == nil {
      annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "interestingPlace")
    } else {
      annotationView?.annotation = annotation
    }
    annotationView?.pinTintColor = UIColor.blueColor()
    annotationView?.canShowCallout = true
    if let place = annotation as? OldPlace, let image = UIImage(named: place.imageName) {
      annotationView?.detailCalloutAccessoryView = UIImageView(image: image)
    }
    
    return annotationView
  }
  
  func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
    let lineView = MKPolygonRenderer(overlay: overlay)
    lineView.strokeColor = UIColor.greenColor()
    lineView.lineWidth = 4.0
    return lineView
  }
  
}