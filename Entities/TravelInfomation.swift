//
//  TravelInfomation.swift
//  BusTimes
//
//  Created by Ade Adegoke on 18/11/2018.
//  Copyright © 2018 AKA. All rights reserved.
//

import Foundation

struct TravellInfomation: Codable {
    var stopPoints: [BusInfo]
}

struct BusInfo: Codable {
    
    var naptanId: String
    var commonName: String
    var distance: Double
    var additionalProperties: [AdditionalProperties]
    var lat: Double
    var lon: Double
    var lines: [Lines]
    
}

struct AdditionalProperties: Codable {
    var value: String
    var key: String
}

struct Lines: Codable {
    //var id: String
    var name: String
    //var uri: String
}


struct BusArrivalData: Codable {
    var busTimes: [BusTimes]
}

struct BusTimes: Codable {
    var timeToStation: Int
    var stationName: String
    var lineName: String 
}

