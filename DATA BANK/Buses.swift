//
//  Buses.swift
//  BusTimes
//
//  Created by Ade Adegoke on 14/01/2019.
//  Copyright © 2019 AKA. All rights reserved.
//

import Foundation

class Buses : NSObject, NSCoding {
    
    var busNumber: String
    var arrivalTime: Int
    var destination: String
    
    init(busNumber: String, arrivalTime: Int, destination: String) {
        self.busNumber = busNumber
        self.arrivalTime = arrivalTime
        self.destination = destination
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let arrivalTime = aDecoder.decodeInteger(forKey: "arrivalTime") as Int
        let busNumber = aDecoder.decodeObject(forKey: "busNumber") as? String ?? ""
        let destination = aDecoder.decodeObject(forKey: "destination") as? String ?? ""
        self.init(busNumber: busNumber, arrivalTime: arrivalTime, destination: destination)
    }
    
    func encode(with aCoder: NSCoder)  {
        aCoder.encode(arrivalTime, forKey: "arrivalTime")
        aCoder.encode(busNumber, forKey: "busNumber")
        aCoder.encode(destination, forKey: "destination")
    }
    
}

