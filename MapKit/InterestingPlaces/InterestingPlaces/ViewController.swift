import UIKit
import CoreLocation

class ViewController: UIViewController {
  
  @IBOutlet weak var placeName: UILabel!
  @IBOutlet weak var locationDistance: UILabel!
  @IBOutlet weak var placeImage: UIImageView!
  var locationManager: CLLocationManager?
  var startLocation: CLLocation?
  @IBOutlet weak var address: UILabel!
  var places:[OldPlace] = []
  var selectedPlaces:OldPlace? = nil
  var geocoder: CLGeocoder?
  
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
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "MapSegue" {
      let mapController = segue.destinationViewController as! mapVCViewController
      mapController.selectedPlace = selectedPlaces
      mapController.places = places
    }
  }
  
  
  @IBAction func startLocationService(sender: AnyObject) {
    startLocationService()
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
    
    if geocoder == nil {
      geocoder = CLGeocoder()
    }
    
    geocoder?.reverseGeocodeLocation((selectedPlaces?.location)!) {
      [weak self] (placemarks, error) in
      if placemarks?.count > 0 {
        guard let currentPlacemark = placemarks?.first else {
          return
        }
        if let streetNumber = currentPlacemark.subThoroughfare,
          let street = currentPlacemark.thoroughfare,
          let city = currentPlacemark.locality,
          let state = currentPlacemark.administrativeArea
        {
          self?.address.text = "\(streetNumber) \(street) \(city), \(state)"
        }
      }
    }
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
      if CLLocationManager.isMonitoringAvailableForClass(CLCircularRegion) {
        for place in places {
          let region = CLCircularRegion(center: place.location.coordinate, radius: 500, identifier: place.name)
          region.notifyOnEntry = true
          region.notifyOnExit = true
          locationManager?.startMonitoringForRegion(region)
        }
      }
    }
    locationManager?.startUpdatingLocation()
  }
  
  func locationManager(manager: CLLocationManager, didEnterRegion region: CLRegion) {
    if presentedViewController == nil {
      let alertController = UIAlertController(title: "Interesting Location Nearby", message: "You are near \(region.identifier). Check it out!", preferredStyle: .Alert)
      let alertAction = UIAlertAction(title: "OK", style: .Default) {
        [weak self] action in
        self?.dismissViewControllerAnimated(true, completion: nil)
      }
      alertController.addAction(alertAction)
      presentViewController(alertController, animated: true, completion: nil)
    }
  }
  
  func locationManager(manager: CLLocationManager, didExitRegion region: CLRegion) {
    print("error for")
  }
  
  func locationManager(manager: CLLocationManager, monitoringDidFailForRegion region: CLRegion?, withError error: NSError) {
    print(error)
  }
}
