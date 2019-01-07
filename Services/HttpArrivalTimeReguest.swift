//
//  HttpArrivalTimeReguest.swift
//  BusTimes
//
//  Created by Ade Adegoke on 18/12/2018.
//  Copyright © 2018 AKA. All rights reserved.
//

import Foundation

class HttpArrivalTimeReguest: ArrivalTimeAPI {
    func fetchBusData(busStopID: String, completion: @escaping BusDataSourceCompletionHandler) {
        let url = "https://api.tfl.gov.uk/StopPoint/\(busStopID)//arrivals"
        guard let busTimesURL = URL(string: url) else { return }
        
        let session = URLSession.shared.dataTask(with: busTimesURL) {(data, response, error) in
            if let error = error {
                DispatchQueue.main.async {
                    completion(Results.failure(DataSourceError.network(error)))
                }
            }
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(Results.failure(DataSourceError.noData))
                }
                return
            }
            
            do {
                let busArrivalData = try JSONDecoder().decode([BusTimes].self, from: data)
                let parsedResult = busArrivalData
                DispatchQueue.main.async {
                    completion(Results.success(parsedResult))
                }
            } catch let error {
                DispatchQueue.main.async {
                    completion(Results.failure(DataSourceError.dataError(error)))
                }
            }
        }
        session.resume()
    }
    
}

