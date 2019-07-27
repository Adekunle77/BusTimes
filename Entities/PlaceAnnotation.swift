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
    var busDirection: String
    var busNumber: String
    var arrivalTime: String
    var annotationasSubtitle: String
    
    init(coordinate: CLLocationCoordinate2D,
         title: String, busStopTitle: String,
         busDirection: String,
         arrivalTime: String,
         annotationasSubtitle: String) {
        self.coordinate = coordinate
        self.title = title
        self.busDirection = busDirection
        self.busNumber = busStopTitle
        self.arrivalTime = arrivalTime
        self.annotationasSubtitle = annotationasSubtitle
        super.init()
    }
    
    var subtitle: String? {
        return annotationasSubtitle
    }
    
}
