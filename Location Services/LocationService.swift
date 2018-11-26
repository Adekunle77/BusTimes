//
//  LocationService.swift
//  BusTimes
//
//  Created by Ade Adegoke on 19/11/2018.
//  Copyright © 2018 AKA. All rights reserved.
//

import Foundation
import CoreLocation

typealias Coordinate = (latitude: Double, longitude: Double)

class LocationService: NSObject, CLLocationManagerDelegate {
    
    private var didReceiveLocation = false
    private let locationManager = CLLocationManager()
    var currentCoordinate: Coordinate?
   
    enum LocationServiceStatus {
        case notDetermined, disabled, denied, authorised
    }
    var status: LocationServiceStatus?
    let onLocationUpdate: (Coordinate) -> ()
    init(onLocationUpdate: @escaping (Coordinate) -> ()) {
        self.onLocationUpdate = onLocationUpdate
        super.init()
       // status = .notDetermined
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
//        if CLLocationManager.locationServicesEnabled() {
//            switch CLLocationManager.authorizationStatus() {
//            case .notDetermined:
//                status = .notDetermined
//                self.locationManager.requestWhenInUseAuthorization()
//            case .restricted, .denied:
//                status = .denied
//            case .authorizedAlways, .authorizedWhenInUse:
//                status = .authorised
//            }
//        } else {
//            status = .disabled
//        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
//        switch status {
//        case .notDetermined, .restricted, .denied:
//            self.status = .notDetermined
//    
//        case .authorizedAlways, .authorizedWhenInUse:
//            self.status = .authorised
//            self.startLocationManager()
//        }
    }
    
    func startLocationManager() {
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ coreLocationManager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
      
        if didReceiveLocation {
            return
        }
        
        guard let location = locations.first else {
            return
        }
        didReceiveLocation = true
        let lat = location.coordinate.latitude
        let long = location.coordinate.longitude
        coreLocationManager.stopUpdatingLocation()
        currentCoordinate = (lat, long)
        onLocationUpdate((lat, long))
    
    }
    
}
