//
//  DataSource.swift
//  BusTimes
//
//  Created by Ade Adegoke on 15/11/2018.
//  Copyright © 2018 AKA. All rights reserved.
//

import Foundation

typealias DataSourceCompletionHandler = (_ results: Results<[BusInfo], DataSourceError> ) -> Void

typealias BusDataSourceCompletionHandler = (_ results: Results<[StopDetails], DataSourceError> ) -> Void 

enum DataSourceError: Error {
    case fatel(String)
    case network(Error)
    case noData
    case dataError(Error)
    case jsonParseError(Error)
    
}

protocol API {
    func fetchAPIData(completion: @escaping DataSourceCompletionHandler)
    
}

protocol ArrivalTimeAPI {
    func fetchBusData(busStopID: String, completion: @escaping BusDataSourceCompletionHandler)
}
