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
    var distance: Int
    var additionalProperties: [AdditionalProperties]
}

struct AdditionalProperties: Codable {
    var value: String
}
