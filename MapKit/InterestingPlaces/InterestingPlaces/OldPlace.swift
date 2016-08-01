import Foundation
import MapKit

class OldPlace : NSObject {
  
  let location:CLLocation
  let name : String
  let imageName : String
  
  init(latitude:Double, longitude:Double, name:String, imageName:String) {
    self.location = CLLocation(latitude: latitude, longitude:longitude)
    self.name = name
    self.imageName = imageName
  }
  
}

extension OldPlace : MKAnnotation {
  
  var coordinate: CLLocationCoordinate2D {
    get {
      return location.coordinate
    }
  }
  
  var title:String? {
    return name
  }
  
}