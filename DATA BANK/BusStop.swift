//
//  BusStop.swift
//  BusTimes
//
//  Created by Ade Adegoke on 01/01/2019.
//  Copyright © 2019 AKA. All rights reserved.
//

import Foundation

class BusStop: NSObject, NSCoding {
    
    var stopName: String
    var stopID: String
    var lat: Double
    var long: Double
    var distance: Double
    var buses: [Buses]
    
    init(stopName: String,
         stopID: String,
         lat: Double,
         long: Double,
         distance: Double,
         buses: [Buses]) {
        self.stopName = stopName
        self.stopID = stopID
        self.lat = lat
        self.long = long
        self.distance = distance
        self.buses = buses
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let stopName = aDecoder.decodeObject(forKey: "stopName") as? String ?? ""
        let stopID = aDecoder.decodeObject(forKey: "stopID") as? String ?? ""
        let lat = aDecoder.decodeDouble(forKey: "lat") as Double
        let long = aDecoder.decodeDouble(forKey: "long") as Double
        let distance = aDecoder.decodeDouble(forKey: "distance") as Double
        let buses = aDecoder.decodeObject(forKey: "buses") as? [Buses] ?? []
        self.init(stopName: stopName,
                  stopID: stopID,
                  lat: lat, long: long,
                  distance: distance,
                  buses: buses)
    }
    
    func encode(with aCoder: NSCoder)  {
        aCoder.encode(stopName, forKey: "stopName")
        aCoder.encode(stopID, forKey: "stopID")
        aCoder.encode(lat, forKey: "lat")
        aCoder.encode(long, forKey: "long")
        aCoder.encode(distance, forKey: "distance")
        aCoder.encode(buses, forKey: "buses")
    }
    
}
