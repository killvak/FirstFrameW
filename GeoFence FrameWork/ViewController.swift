//
//  ViewController.swift
//  GeoFence FrameWork
//
//  Created by K/Users/killvak/Desktop/Level 4 /GeoFence FrameWork/GeoFence FrameWorkillvak on 16/02/2017.
//  Copyright © 2017 Killvak. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController , MKMapViewDelegate , CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    
    
    var geotifications : [Geotification] = []
    var mapHasCenteredOnce = false
    let setupAnnotation = SetUpAnnotations()
    let getData = GetData()
    
    
    
     override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        ///set the location Manager Delegate  equal to the viewController so that the view controller can receivr the reevant delegate mthod calls.
        locationManager.delegate = self
        mapView.userTrackingMode = MKUserTrackingMode.follow
       self.geotifications = getData.xyz(data: data2)
        /**
 You make a call to requestAlwaysAuthorization(), which invokes a prompt to the user requesting for Always authorization to use location services. Apps with geofencing capabilities need Always authorization, due to the need to monitor geofences even when the app isn’t running. Info.plist has already been setup with a message to show the user when requesting the user’s location under the key NSLocationAlwaysUsageDescription.
 */
        locationManager.requestAlwaysAuthorization()
        /**
 You call loadAllGeotifications(), which deserializes the list of geotifications previously saved to NSUserDefaults and loads them into a local geotifications array. The method also loads the geotifications as annotations on the map view.
 */
        setupAnnotation.setupAnnotationDataOnMap( anotationsArray: geotifications, mapView: mapView ,locationManager : locationManager)
  
        ///when data is online
        
        //offline data 
//        setupAnnotation.loadAllGeotifications(mapView: self.mapView, raduis: 100, annoationArray: &self.geotifications)

        //        mapView.userTrackingMode = MKUserTrackingMode.follow
        //        locationManager.requestAlwaysAuthorization()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //        self.locationAuthStatus()
    }

    /**
     The location manager calls locationManager(_:didChangeAuthorizationStatus:) whenever the authorization status changes. If the user has already granted the app permission to use Location Services, this method will be called by the location manager after you’ve initialized the location manager and set its delegate.
     That makes this method an ideal place to check if the app is authorized. If it is, you enable the map view to show the user’s current location.
 */
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        mapView.showsUserLocation = (status == .authorizedAlways)
    }
  
 ///Annotation Frame
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        return  setupAnnotation.mapView(mapView, viewFor: annotation)
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
    return setupAnnotation.mapView(mapView, rendererFor: overlay)
            }
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        // Delete geotification
        let geotification = view.annotation as! Geotification
   
        performSegue(withIdentifier: "test", sender: geotification )
        
    }
    
    @IBAction func zoomToUserLocation(_ sender: UIButton) {
//        mapView.zoomToUserLocation(latitudinalMeters: 200, longitudinalMeters: 200)
//        mapView.userTrackingMode = MKUserTrackingMode.follow

//        for x in mapView.annotations {
//            mapView.removeAnnotation(x)
//        }
//        setupAnnotation.loadAllGeotifications(mapView: self.mapView, raduis: 100, annoationArray: &self.geotifications)
     }
    /// @end
}

