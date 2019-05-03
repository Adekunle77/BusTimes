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
    var busesArray: [String]
    var arrivalTimes: [Int]

    init(stopName: String, stopID: String, lat: Double, long: Double, distance: Double, busesArray: [String], arrivalTimes: [Int]) {
        self.stopName = stopName
        self.stopID = stopID
        self.lat = lat
        self.long = long
        self.distance = distance
        self.busesArray = busesArray
        self.arrivalTimes = arrivalTimes
        
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let stopName = aDecoder.decodeObject(forKey: "stopName") as? String ?? ""
        let stopID = aDecoder.decodeObject(forKey: "stopID") as? String ?? ""
        let lat = aDecoder.decodeDouble(forKey: "lat") as Double
        let long = aDecoder.decodeDouble(forKey: "long") as Double
        let distance = aDecoder.decodeDouble(forKey: "distance") as Double
        let busesArray = aDecoder.decodeObject(forKey: "busesArray") as? [String] ?? [""]
        let arrivalTimes = aDecoder.decodeObject(forKey: "arrivalTimes") as? [Int] ?? []
        
        self.init(stopName: stopName, stopID: stopID, lat: lat, long: long, distance: distance, busesArray: busesArray, arrivalTimes: arrivalTimes)
    }
    
    func encode(with aCoder: NSCoder)  {
        aCoder.encode(stopName, forKey: "stopName")
        aCoder.encode(stopID, forKey: "stopID")
        aCoder.encode(lat, forKey: "lat")
        aCoder.encode(long, forKey: "long")
        aCoder.encode(distance, forKey: "distance")
        aCoder.encode(busesArray, forKey: "busesArray")
        aCoder.encode(arrivalTimes, forKey: "arrivalTimes")
        
    }
    
}
