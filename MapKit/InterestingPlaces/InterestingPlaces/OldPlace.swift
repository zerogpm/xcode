import Foundation
import CoreLocation

class OldPlace {
  
  let location:CLLocation
  let name : String
  let imageName : String
  
  init(latitude:Double, longitude:Double, name:String, imageName:String) {
    self.location = CLLocation(latitude: latitude, longitude:longitude)
    self.name = name
    self.imageName = imageName
  }
  
}