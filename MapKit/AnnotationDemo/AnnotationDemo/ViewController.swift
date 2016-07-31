import UIKit
import MapKit

class ViewController: UIViewController {

  var headquarters: [Headquarters] = []
  @IBOutlet weak var mapView: MKMapView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    loadHeadquarters()
    mapView.delegate = self
    mapView.mapType = .Standard
    mapView.rotateEnabled = false
    mapView.addAnnotations(headquarters)
    
    let reginonRadius: CLLocationDistance = 15000
    let hq = headquarters.first
    let coordinateRegion = MKCoordinateRegionMakeWithDistance(
      (hq?.location.coordinate)!, reginonRadius, reginonRadius)
    mapView.setRegion(coordinateRegion, animated: true)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func loadHeadquarters() {
    guard let plistUrl = NSBundle.mainBundle().URLForResource("headquarters", withExtension: "plist"), let plistData = NSData(contentsOfURL: plistUrl) else { return }
    var format = NSPropertyListFormat.XMLFormat_v1_0
    var placedEntries: NSArray? = nil
    
    do {
      placedEntries = try NSPropertyListSerialization.propertyListWithData(plistData, options:.Immutable, format: &format) as? NSArray
    } catch {
      print("error reading plist")
    }
    if placedEntries != nil {
      for property in placedEntries! {
        if let name = property["Name"] as? String,
          let latitude = property["Latitude"] as? NSNumber,
          let longitude = property["Longitude"] as? NSNumber,
          let image = property["Image"] as? String,
          let type = property["Type"] as? String
        {
          let companyHeadquarters = Headquarters(name: name, type: type, imageName: image, latitude: latitude.doubleValue, longitude: longitude.doubleValue)
          headquarters.append(companyHeadquarters)
        }
      }
    }

  }
}

extension ViewController: MKMapViewDelegate {
  func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
    if annotation is MKUserLocation {
      return nil
    }
    
    var annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier("rechHQ") as? MKPinAnnotationView
    
    if annotationView == nil {
      annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "techHQ")
    } else {
      annotationView?.annotation = annotation
    }
    
    annotationView?.pinTintColor = UIColor.orangeColor()
    annotationView?.canShowCallout = true

    if let place = annotation as? Headquarters,let image = place.image {
      annotationView?.detailCalloutAccessoryView = UIImageView(image:image)
      annotationView?.animatesDrop = true
    }
    
    return annotationView
  }
}