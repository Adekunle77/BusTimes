//
//  PlaceAnnotation.swift
//  BusTimes
//
//  Created by Ade Adegoke on 13/12/2018.
//  Copyright © 2018 AKA. All rights reserved.
//

import Foundation
import MapKit

class PlaceAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var busDirection: String?
    var busStopTitle: Int?
    
    
    init(coordinate: CLLocationCoordinate2D, title: String, busStopTitle: Int, busDirection: String ) {
        self.coordinate = coordinate
        self.title = title
        self.busDirection = busDirection
        self.busStopTitle = busStopTitle
        
    }
    
    
}
