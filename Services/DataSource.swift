//
//  DataSource.swift
//  BusTimes
//
//  Created by Ade Adegoke on 15/11/2018.
//  Copyright © 2018 AKA. All rights reserved.
//

import Foundation

typealias DataSourceCompletionHandler = (_ results: Results<[TravellInfomation], DataSourceError> ) -> Void

enum DataSourceError: Error {
    case fatel(String)
    case network(String)
    case noData
    case dataError(Error)
    case jsonParseError(Error)
    
}

protocol API {
    func fetchAPIData(completion: @escaping DataSourceCompletionHandler)
}
