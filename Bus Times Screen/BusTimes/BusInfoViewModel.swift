//
//  BusInfoViewModel.swift
//  BusTimes
//
//  Created by Ade Adegoke on 26/11/2018.
//  Copyright © 2018 AKA. All rights reserved.
//

import Foundation
import MapKit

protocol ViewModelDelegate: class {
    func modelDidupdate()
    func modelDidUpdateWithError(error: Error)
}

 class BusInfoViewModel {
    
    var busInfoArray = [BusInfo]()
    var annotationArray = [PlaceAnnotation]()
    var busesArrivalTime = HttpArrivalTimeReguest()
    weak var delegate: ViewModelDelegate?
    private var savedBusStopInfo = [BusStop]()
    var locationService: LocationService!
    var savedData = SaveDataOperation()

    init() {
        savedData.loadUserDefaultData()        
    }

    func setMapView(mapView: MKMapView) {
        let usersCurrentCoordinates = savedData.getUserCoordinates()
        let locatoion = CLLocation(latitude: usersCurrentCoordinates.latitude,
                                   longitude: usersCurrentCoordinates.longitude)
        let viewRegion = MKCoordinateRegion(center: locatoion.coordinate,
                                            latitudinalMeters: 250,
                                            longitudinalMeters: 250)
        mapView.setRegion(viewRegion, animated: true)
    }

    func clearCurrentView() {
        savedData.clearSavedData()
    }
    
    func getlatestBusInfo() {
        savedData.runTimedCode()
        savedData.loadUserDefaultData()
    }
    
    func removeAnnotatonInfo(mapView: MKMapView ) {
        let allAnnotations = mapView.annotations
        mapView.removeAnnotations(allAnnotations)
    }
    
    func addAnnotation(mapView: MKMapView) {
        
    }

    func addAnnotationTo(mapView: MKMapView ) {
        if savedData.savedBusStopInfos.isEmpty {
            return
        } else {
            savedBusStopInfo = savedData.savedBusStopInfos
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 5 ) {
            for stopInfo in self.savedBusStopInfo {
                let latitude = CLLocationDegrees(stopInfo.lat)
                let longitude = CLLocationDegrees(stopInfo.long)
                let location = CLLocation(latitude: latitude, longitude: longitude)
                
                var nextBus = String()
                var arrivalTime = String()
                var direction = String()
                var followingBuses = self.getFollowingBusList(from: stopInfo.buses)
                
                let sortedBusInfo = stopInfo.buses.sorted(by: { $0.arrivalTime > $1.arrivalTime })
                
                for bus in sortedBusInfo {
                    nextBus = bus.busNumber
                    var busTime: String {
                        if bus.arrivalTime == 0 {
                            return "Due"
                        }
                        return "\(String(bus.arrivalTime)) minutes"
                    }
                    arrivalTime = busTime
                    direction = bus.destination
                }
                
                let annotation = PlaceAnnotation(coordinate: location.coordinate,
                                                 title: stopInfo.stopName,
                                                 busStopTitle: nextBus,
                                                 busDirection: direction,
                                                 arrivalTime: arrivalTime,
                                                 annotationasSubtitle: followingBuses)

                self.annotationArray.append(annotation)
                mapView.addAnnotation(annotation)
                
                DispatchQueue.main.async {
                    self.setMapView(mapView: mapView)
                }
            }
            self.delegate?.modelDidupdate()
        }
    }

    func getFollowingBusList(from buses: [Buses]) -> String {
        var followingBuses = String()        
        for bus in buses {
            followingBuses +=  "\(bus.busNumber) arrives in \(bus.arrivalTime) minutes,  "
        }
        return followingBuses
    }
    
}

