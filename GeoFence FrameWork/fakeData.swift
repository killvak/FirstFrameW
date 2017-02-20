//
//  fakeData.swift
//  GeoFence FrameWork
//
//  Created by Killvak on 20/02/2017.
//  Copyright © 2017 Killvak. All rights reserved.
//

import Foundation
import CoreLocation

let data2 = ["AppsSquare" : (30.794940197245495, 30.996800645431936), "My Cafe" : (37.703026, -121.759735), "My Cafe2" : (37.702976, -121.760731), "My Cafe3" : (37.702894, -121.761717), "My Cafe4" : (37.702799, -121.762568), "My Cafe5" : (37.702606, -121.763943)]
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
