//
//  Extensions.swift
//  GeoFence FrameWorkﬁ
//
//  Created by Killvak on 16/02/2017.
//  Copyright © 2017 Killvak. All rights reserved.
//
let data = ["AppsSquare" : CLLocationCoordinate2DMake(30.794940197245495, 30.996800645431936) , "Home Sweet Home" : CLLocationCoordinate2DMake(30.794245547170974, 31.003918368602754) , "My Cafe" : CLLocationCoordinate2DMake(37.703026, -121.759735)]
let data2 = ["AppsSquare" : (30.794940197245495, 30.996800645431936) , "Home Sweet Home" : (30.794245547170974, 31.003918368602754) , "My Cafe" : (37.703026, -121.759735)]

import Foundation
import  MapKit

extension MKMapView {
    
    func zoomToUserLocation(latitudinalMeters: CLLocationDistance ,longitudinalMeters: CLLocationDistance ) {
        guard let coordinate = userLocation.location?.coordinate  else {
            return
        }
        let region = MKCoordinateRegionMakeWithDistance(coordinate, latitudinalMeters, longitudinalMeters)
        setRegion(region, animated: true)
    }
}

struct PreferencesKeys {
    static let savedItems = "savedItems"
}


class GetData  {
    
    func xyz(data : Dictionary<String,(Double,Double)>) -> [Geotification]{
        var arr = [Geotification]()
        for z in data {
            let y = Geotification(coordinate: CLLocationCoordinate2D( latitude: z.value.0,  longitude: z.value.1), radius: 100, identifier: NSUUID().uuidString, note: z.key, eventType: EventType.onEntry   )
            arr.append(y)
        }
        return arr
}
}

class MapData : NSObject {
    
   private var _title : String?
   private var _latitude : Double?
   private var _longitude : Double?
     var _coordinates : CLLocationCoordinate2D?
    var title : String {
        guard let title = _title else { return ""}
        return title
    }
    var latitude : Double {
        guard let latitude = _latitude else { return 0.0}
        return latitude
    }
    var longtitude : Double {
        guard let longtitude = _longitude else { return 0.0}
        return longtitude
    }
 
 
    
    init(title : String , latitude : Double , long : Double) {
        self._title = title
        self._latitude = latitude
        self._longitude = long
        self._coordinates = CLLocationCoordinate2D(latitude: latitude, longitude: long)
    }
    
}



// MARK: Helper Extensions
extension UIViewController {
    func showAlert(withTitle title: String?, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}
