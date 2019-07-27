//
//  SavedData.swift
//  BusTimes
//
//  Created by Ade Adegoke on 27/11/2018.
//  Copyright © 2018 AKA. All rights reserved.
//

import Foundation

protocol SavingDataDelegate {
    func saveToUserDefault(save: [BusStop])
    func loadUserDefaultData()
    var savedBusStopInfos: [BusStop] { get set }
    
}

class SaveDataOperation: SavingDataDelegate {

    private var savedDATA = [BusStop]()
    private var locationService: LocationService!
    private var busesArrivalTime = HttpArrivalTimeReguest()
    private let userDefaults = UserDefaults.standard
    var savedBusStopInfos = [BusStop]()
    var dataSavedDelegate: SavingDataDelegate?

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
                        self.sortAPIData(data: busInfo)
                }
            }
        }
    }

    private func sortAPIData(data: [BusInfo]) {
        clearSavedData()
        var busStops = [BusStop]()
        for info in data {
            
            requestArrivalTimes(busID: info.naptanId, then: { result in
                let array = result
                    var busesDetails = [Buses]()
                    array.forEach { result in
                        let number = result.lineName
                        let time = result.timeToStation / 60
                        let busDestination = result.destinationName
                        let bus = Buses(busNumber: number, arrivalTime: time, destination: busDestination)
                        busesDetails.append(bus)
                    }
                let sortedBusDetails = busesDetails.sorted{ $0.arrivalTime < $1.arrivalTime }
                let busStop = BusStop(stopName: info.commonName,
                                      stopID: info.naptanId,
                                      lat: info.lat, long: info.lon,
                                      distance: info.distance,
                                      buses: sortedBusDetails)
                busStops.append(busStop)
                self.savedDATA = busStops
                self.saveToUserDefault(save: busStops)
            })
        }
        
    }

    private func requestArrivalTimes(busID: String, then completion: @escaping ([StopDetails]) -> Void) {
        self.busesArrivalTime.fetchBusData(busStopID: busID, completion: { result in
            var busArrivalTime = [StopDetails]()
            switch result {
            case .failure(let error):
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

    func getUserCoordinates() -> Coordinate {
        guard let coodinates = self.locationService.currentCoordinate else {
            return  (0, 0) }
        return coodinates
    }

    func saveToUserDefault(save: [BusStop]) {
        let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: save)
        userDefaults.set(encodedData, forKey: "busStopData")
        UserDefaults.standard.synchronize()
        
    }

    func loadUserDefaultData() {
        guard let data = UserDefaults.standard.object(forKey: "busStopData") as? NSData else { return }
        guard let busStopSavedData = NSKeyedUnarchiver.unarchiveObject(with: data as Data) as? [BusStop] else { return }
        self.savedBusStopInfos = busStopSavedData
    }

    func clearSavedData() {
        userDefaults.removeObject(forKey: "busStopData")
        self.savedBusStopInfos.removeAll()
    }
}



