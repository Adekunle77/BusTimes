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
    var lat: Double
    var lon: Double
}

struct StopDetails: Codable {
    var timeToStation: Int
    var lineName: String
    var destinationName: String
    var timeToLive: String 
}

