//
//  HttpRequest.swift
//  BusTimes
//
//  Created by Ade Adegoke on 18/11/2018.
//  Copyright © 2018 AKA. All rights reserved.
//

import Foundation

class HttpTravelInfoRequest: API {

    let usersCoordinates: Coordinate
    init(coordinates: Coordinate) {
        self.usersCoordinates = coordinates
    }
    
    
    func fetchAPIData(completion: @escaping DataSourceCompletionHandler) {
        
        let url = "https://api.tfl.gov.uk/Stoppoint?lat=\(String(describing: usersCoordinates.latitude))&lon=\(String(describing: usersCoordinates.longitude))&stoptypes=NaptanPublicBusCoachTram&radius=300&app_id=25fb89a8&app_key=d14564cd46a7d5cb31bc2c396038d68f"
        
        guard let busURL = URL(string: url) else {
            return
        }
        let session = URLSession.shared.dataTask(with: busURL) {(data, response, error) in
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
                let jsonDecoder = JSONDecoder()
                let searchResult = try jsonDecoder.decode(TravellInfomation.self, from: data)
                let parsedResult = searchResult.stopPoints
                    DispatchQueue.main.async {
                        completion(Results.success(parsedResult))
                }
            } catch let error {
                    DispatchQueue.main.async {
                        completion(Results.failure(DataSourceError.dataError(error)))
                }
            }
            
            
//            do {
//                let busData = try JSONDecoder().decode(TravellInfomation.self, from: data)
//                let parsedBusData = busData.stopPoints
//                DispatchQueue.main.async {
//                    completion(Results.success(parsedBusData))
//                }
//            } catch {
//                DispatchQueue.main.async {
//                    completion(Results.failure(DataSourceError.dataError(error)))
//                    }
//                }
            }
        session.resume()
    }
    
}
