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
    var savedData = SaveData()
    var annotationArray = [PlaceAnnotation]()
    var busesArrivalTime = HttpArrivalTimeReguest()
    weak var delegate: ViewModelDelegate?
    
    var locationService: LocationService!
    
    init() {

        locationService = LocationService {
            HttpTravelInfoRequest(coordinates: $0).fetchAPIData { [weak self] (result) in
                switch result {
                case .failure(let error):
                    self?.delegate?.modelDidUpdateWithError(error: error)
                case .success(let busInfo):
                    self?.busInfoArray = busInfo
                    self?.delegate?.modelDidupdate()
                    
                }
            }
        }

    }

    func setMapView(mapView: MKMapView) {
        guard let usersCurrentCoordinates = locationService.currentCoordinate else { return}
        let locatoion = CLLocation(latitude: usersCurrentCoordinates.latitude, longitude: usersCurrentCoordinates.longitude)
        let viewRegion = MKCoordinateRegion(center: locatoion.coordinate, latitudinalMeters: 400, longitudinalMeters: 400)
        mapView.setRegion(viewRegion, animated: true)
    }
    
    func annotation(mapView: MKMapView) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 5 ) {
            
        }
    }
    
    
    
    func addAnnotationTo(mapView: MKMapView ) {
       
        DispatchQueue.main.asyncAfter(deadline: .now() + 5 ) {

            if self.busInfoArray.isEmpty {
          
            } else {
                for busInfo in self.busInfoArray {
                    let latitude = CLLocationDegrees(busInfo.lat)
                    let longitude = CLLocationDegrees(busInfo.lon)
                    let location = CLLocation(latitude: latitude, longitude: longitude)
                    var busTitle: String {  
                        var busNumber = "Bues: "
                        for number in busInfo.lines {
                            busNumber += number.name + ", "
                        }
                        return busNumber
                    }
                    
                    let busID = busInfo.naptanId
                    var arrivalTime = Int()
                
                        self.getBusArrivalTimes(busID: busID, then: { result in
                            arrivalTime =  self.didReceiveArrivalTimes(result)
                        let annotation = PlaceAnnotation(coordinate: location.coordinate, title: busInfo.commonName, busStopTitle: arrivalTime , busDirection: "No Time Available")
                          
                            self.annotationArray.append(annotation)
                            mapView.addAnnotation(annotation)
                            DispatchQueue.main.async {
                                mapView.addAnnotation(annotation)
                                self.setMapView(mapView: mapView)
                            }
                    })
                }
            }
        }

    }
      
    func didReceiveArrivalTimes(_ times: [Int]) -> Int {
       return times.first ?? 0
    }

    func getBusArrivalTimes(busID: String, then completion: @escaping ([Int]) -> Void) {
        self.busesArrivalTime.fetchBusData(busStopID: busID, completion: { result in
            var busArrivalTime = [Int]()
            switch result {
                case .failure(let error):
                    self.delegate?.modelDidUpdateWithError(error: error)
                    return
                case .success(let arrivalTime):
                    for time in arrivalTime {
                        busArrivalTime.append(time.timeToStation)
                }
            }
            completion(busArrivalTime)
        })
    }
    
}
