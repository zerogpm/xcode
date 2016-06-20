import UIKit
import CoreLocation

class ViewController: UIViewController {
  
  @IBOutlet weak var placeName: UILabel!
  @IBOutlet weak var locationDistance: UILabel!
  @IBOutlet weak var placeImage: UIImageView!
  var locationManager: CLLocationManager?
  var startLocation: CLLocation?
  
  var places:[OldPlace] = []
  var selectedPlaces:OldPlace? = nil
  
  override func viewDidLoad() {
    super.viewDidLoad()
    locationManager = CLLocationManager()
    locationManager?.delegate = self
    locationManager?.desiredAccuracy = kCLLocationAccuracyBest
    loadPlaces()
    selectedPlaces = places.first
    updateUI()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  @IBAction func startLocationService(sender: AnyObject) {
    
  }
  
  func startLocationService() {
    if CLLocationManager.authorizationStatus() != .AuthorizedWhenInUse {
      locationManager?.requestWhenInUseAuthorization()
    } else {
      locationManager?.requestLocation()
    }
  }
  
  @IBAction func selectPlace(sender: AnyObject) {
    guard let button = sender as? UIButton else { return }
    selectedPlaces = places[button.tag]
    updateUI()
  }
  
  func updateUI() {
    placeName.text = selectedPlaces?.name
    guard let imageName = selectedPlaces?.imageName, let image = UIImage(named: imageName) else {return}
    placeImage.image = image
    startLocationService()
  }
  
  func loadPlaces() {
    guard let plistUrl = NSBundle.mainBundle().URLForResource("Places", withExtension: "plist"), let plistData = NSData(contentsOfURL: plistUrl) else { return }
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
          let image = property["Image"] as? String {
          
          // To learn how to read data from plist file, check out our Saving Data
          // in iOS Video Tutorial series.
          
          let place = OldPlace(latitude: latitude.doubleValue, longitude: longitude.doubleValue, name: name, imageName: image)
          places.append(place)
          
        }
      }
    }
  }
}

extension ViewController: CLLocationManagerDelegate {
  
  func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    if startLocation == nil {
      startLocation = locations.first
    } else {
      guard let selectedPlace = selectedPlaces else {return}
      if let metersFromLocation = startLocation?.distanceFromLocation(selectedPlace.location) {
        let miles = Int((metersFromLocation / 1000) * 0.62137)
        locationDistance.text = "you are \(miles) mile away"
      }
    }
  }
  
  func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
    print(error)
  }
  
  func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
    if status == .AuthorizedAlways || status == .AuthorizedWhenInUse {
      locationManager?.requestLocation()
    }
  }
}
