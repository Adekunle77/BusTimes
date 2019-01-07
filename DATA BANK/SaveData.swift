//
//  SavedData.swift
//  BusTimes
//
//  Created by Ade Adegoke on 27/11/2018.
//  Copyright © 2018 AKA. All rights reserved.
//

import Foundation


class SaveData {
    
    private var savedDATA = [BusStop]()
    private var locationService: LocationService!
    private var busesArrivalTime = HttpArrivalTimeReguest()
    private let userDefaults = UserDefaults.standard
    var savedBusStopInfos = [BusStop]()
    
    init() {
        runTimedCode()
    }
    
   func runTimedCode() {
        locationService = LocationService {
            HttpTravelInfoRequest(coordinates: $0).fetchAPIData { (result) in
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let busInfo):
                    self.getDataFromAPI(data: busInfo)
                }
            }
        }
    }
    
    
    private func getDataFromAPI(data: [BusInfo]) {
        
        userDefaults.removeObject(forKey: "busStopData")
        self.savedBusStopInfos.removeAll()

        var busStops = [BusStop]()
        for info in data {
            getBusArrivalTimes(busID: info.naptanId, then: { result in
                var array = result
                array.sort { $0.timeToStation < $1.timeToStation }
                    var arrivalTimes = [Int]()
                    var buses = [String]()
                    array.forEach { result in
                        let number = result.lineName
                        let time = result.timeToStation / 60
                        arrivalTimes.append(time)
                        buses.append(number)
                    }
                let busStop = BusStop(stopName: info.commonName, stopID: info.naptanId, lat: info.lat, long: info.lon, distance: info.distance, busesArray: buses , arrivalTimes: arrivalTimes)
                busStops.append(busStop)
                self.savedDATA = busStops
                self.saveBusStopData()
            })
        }
        
    }
    
    
    private func getBusArrivalTimes(busID: String, then completion: @escaping ([BusTimes]) -> Void) {
        
        self.busesArrivalTime.fetchBusData(busStopID: busID, completion: { result in
            var busArrivalTime = [BusTimes]()
            switch result {
            case .failure(let error):
               // self.delegate?.modelDidUpdateWithError(error: error)
                print(error)
                return
            case .success(let arrivalTime):
                for time in arrivalTime {
                    busArrivalTime.append(time)
                }
            }
            completion(busArrivalTime)
        })
    }
    
    
    func saveBusStopData() {
        let busStopData = self.savedDATA
            let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: busStopData)
            userDefaults.set(encodedData, forKey: "busStopData")
            UserDefaults.standard.synchronize()

    }

    
    func loadBusStopData() {
            guard let data = UserDefaults.standard.object(forKey: "busStopData") as? NSData else {
                print("'places' not found in UserDefaults")
                return
            }
            
            guard let busStopSavedData = NSKeyedUnarchiver.unarchiveObject(with: data as Data) as? [BusStop] else {
                print("Could not unarchive from busStopData")
                return
            }
            self.savedBusStopInfos = busStopSavedData
    }
    
}



