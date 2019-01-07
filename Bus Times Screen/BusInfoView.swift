//
//  BusInfoScreen.swift
//  BusTimes
//
//  Created by Ade Adegoke on 15/11/2018.
//  Copyright © 2018 AKA. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class BusInfoView: UIViewController {

    @IBOutlet weak private var mapView: MKMapView!
    fileprivate let label = UILabel()
    fileprivate var viewModel = BusInfoViewModel()
    fileprivate let reuseIdentifier = "MyIdentifier"
    fileprivate let identifier = "Identifier"
 
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(label)
        viewModelSetUp()
        
    }

    func viewModelSetUp() {
        viewModel.locationService.startLocationManager()
        viewModel.delegate = self
        viewModel.addAnnotationTo(mapView: mapView)
        //viewModel.setMapView(mapView: mapView)
    }

}

extension BusInfoView: ViewModelDelegate {
    func modelDidupdate() {
//       print(viewModel.busInfoArray.count)
//        print(viewModel.busInfoArray[0].commonName)        
    }
    
    func modelDidUpdateWithError(error: Error) {
       // outLabel.text = error.localizedDescription
    }
    
}

extension BusInfoView: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation { return nil }

        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView
        //annotationView?.canShowCallout = true
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.isEnabled = true
            annotationView?.canShowCallout = true
            annotationView?.rightCalloutAccessoryView = UIButton(type: .infoLight)
            let annotationLabel = UILabel(frame: CGRect(x: -40, y: -35, width: 85, height: 30))
            annotationLabel.numberOfLines = 3
            annotationLabel.textAlignment = .center
            annotationLabel.font = UIFont(name: "Rockwell", size: 10)
            // you can customize it anyway you want like any other label
            annotationLabel.text = annotation.title!
            annotationLabel.backgroundColor = UIColor.white
            annotationLabel.layer.cornerRadius = 15
            annotationLabel.clipsToBounds = true
            annotationView?.addSubview(annotationLabel)
        } else {
            annotationView?.annotation = annotation
        }

        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print("The annoataion was selected: \(String(describing: view.annotation?.title))")
        
    }
}
