//
//  Headquarters.swift
//  AnnotationDemo
//
//  Created by Jian Su on 2016-07-30.
//  Copyright © 2016 Razeware LLC. All rights reserved.
//

import UIKit
import MapKit

class Headquarters : NSObject {
  
  let name:String
  let type: String
  let location: CLLocation
  let image: UIImage?
  
  init(name:String, type:String, imageName:String, latitude:Double, longitude:Double) {
    self.name = name
    self.type = type
    self.location = CLLocation(latitude: latitude, longitude: longitude)
    self.image = UIImage(named: imageName)
  }
  
}

extension Headquarters: MKAnnotation {
  
  var coordinate: CLLocationCoordinate2D {
    get {
      return location.coordinate
    }
  }
  var title:String? {
    return name
  }
  var subtitle:String? {
    return type
  }
  
}