//
//  SetUpAnnotations.swift
//  GeoFence FrameWork
//
//  Created by Killvak on 16/02/2017.
//  Copyright © 2017 Killvak. All rights reserved.
//

import Foundation
import MapKit

class SetUpAnnotations : NSObject {
    
    func setupAnnotationDataOnMap(anotationsArray :  [Geotification] ,mapView :MKMapView  ,locationManager : CLLocationManager ) {
//            raduis = min(raduis, locationManager.maximumRegionMonitoringDistance)
        
      var annotationCount = 0
         print("that is the 1annoationArray data ; \(anotationsArray)")
                for point in anotationsArray {
                    ///add the circle around the annotation
                    guard annotationCount < 20 else { print("annotation exceed 20 annotation : (Count: \(annotationCount))"); return }
                    let clampRadius = min(point.radius, locationManager.maximumRegionMonitoringDistance)
                    let circle = MKCircle(center: point.coordinate, radius:clampRadius)
                    mapView.add(circle)
                    startMonitoring(geotification: point, locationManager: locationManager)
                    annotationCount += 1
                    print("that is the annotation Num : \(annotationCount)")
                }
        mapView.addAnnotations(anotationsArray)
        self.saveAllGeotifications(annoationArray: anotationsArray )

        
    }
    
    func removeMapAnnotations(mapView:MKMapView) {
        
    }
 
    func saveAllGeotifications(annoationArray :  [Geotification]) {
        if  ((UserDefaults.standard.array(forKey: PreferencesKeys.savedItems)) != nil)  {
            print("found  data in the offline storage while saveing new one ")
            UserDefaults.standard.removeObject(forKey: PreferencesKeys.savedItems)
            
             }
        var items: [Data] = []
                for geotification in annoationArray {
                    let item = NSKeyedArchiver.archivedData(withRootObject: geotification)
                    items.append(item)
                }
                UserDefaults.standard.set(items, forKey: PreferencesKeys.savedItems)
            }
    
    func loadAllGeotifications(mapView : MKMapView , raduis : Double,annoationArray : inout [Geotification] ,locationManager : CLLocationManager) {
        annoationArray = []
        print("that is the 1annoationArray data ; \(annoationArray)")

        guard let savedItems = UserDefaults.standard.array(forKey: PreferencesKeys.savedItems) else { return }
        for savedItem in savedItems {
            guard let geotification = NSKeyedUnarchiver.unarchiveObject(with: savedItem as! Data) as? Geotification else { continue }
//            add(geotification: geotification)
            annoationArray.append(geotification)
        }
        print("that is the 2annoationArray data ; \(annoationArray)")

      self.setupAnnotationDataOnMap(anotationsArray: annoationArray, mapView: mapView,  locationManager : locationManager)
    }
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let id = "Field"
        guard annotation is Geotification else {    return nil        }
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: id)
        if annotationView != nil {
            annotationView!.annotation = annotation
        }else {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: id)
            annotationView?.canShowCallout = true
            let btn = UIButton(type: .infoLight)
            annotationView?.rightCalloutAccessoryView = btn
        }
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
                if overlay is MKCircle {
        let circlerender = MKCircleRenderer(overlay: overlay)
        circlerender.strokeColor = UIColor.purple
        circlerender.lineWidth = 1.0
        return circlerender
                }else {
                    return MKOverlayRenderer(overlay: overlay)
                }
    }
}
