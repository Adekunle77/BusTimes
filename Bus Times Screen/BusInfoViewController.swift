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

class BusInfoViewController: UIViewController {

    @IBOutlet weak private var mapView: MKMapView!
    @IBOutlet weak var refreshButton: UIButton!
    fileprivate let label = UILabel()
    fileprivate var viewModel = BusInfoViewModel()
    fileprivate let reuseIdentifier = "MyIdentifier"
    fileprivate let identifier = "Identifier"
 
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(label)
        viewModelSetUp()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        viewModel.clearCurrentView()
    }
    func viewModelSetUp() {
       // viewModel.locationService.startLocationManager()
        viewModel.delegate = self
        viewModel.addAnnotationTo(mapView: mapView)

    }

    @IBAction func getlatestBusInfo(_ sender: Any) {
        viewModel.removeAnnotatonInfo(mapView: self.mapView)
        viewModel.getlatestBusInfo()
        viewModel.addAnnotationTo(mapView: mapView)
    }
  
    
    
}



extension BusInfoViewController: ViewModelDelegate {
    func modelDidupdate() {
//       print(viewModel.busInfoArray.count)
//        print(viewModel.busInfoArray[0].commonName)        
    }
    
    func modelDidUpdateWithError(error: Error) {
       // outLabel.text = error.localizedDescription
    }
    
}

extension BusInfoViewController: MKMapViewDelegate, UIPopoverPresentationControllerDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        guard let annotation = annotation as? PlaceAnnotation else { return nil }
        
        var annotationView: MKPinAnnotationView
        
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView {
            dequeuedView.annotation = annotation
            annotationView = dequeuedView
            
        }
        
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            for view in annotationView.subviews {
                view.removeFromSuperview()
            }
            annotationView.canShowCallout = true
            annotationView.calloutOffset = CGPoint(x: -5, y: 5)
            let annotationLabel = UILabel(frame: CGRect(x: -60, y: -40, width: 125, height: 38))
            annotationLabel.numberOfLines = 3
            annotationLabel.textAlignment = .center
            annotationLabel.font = UIFont(name: "Rockwell", size: 9)
 
            let busNumber = annotation.busNumber
            let busArrivalTime = annotation.arrivalTime
            let direction = annotation.busDirection
            let followingBuses = annotation.annotationasSubtitle
        
            annotationLabel.text = "Next bus: \(busNumber)\n Arrives: \(busArrivalTime) \n Direction: \(direction)"
            annotationLabel.backgroundColor = UIColor.white
            annotationLabel.layer.cornerRadius = 0
            annotationLabel.clipsToBounds = true
            annotationView.addSubview(annotationLabel)

        let label1 = UILabel(frame: CGRect(x:0, y:0, width: 200,  height: 21))
        label1.text = followingBuses
        label1.numberOfLines = 0
        annotationView.detailCalloutAccessoryView = label1;
        
        let width = NSLayoutConstraint(item: label1, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.lessThanOrEqual, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 200)
        label1.addConstraint(width)
        
        let height = NSLayoutConstraint(item: label1, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 90)
        label1.addConstraint(height)

        return annotationView
    }
    
    
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
    //    print("The annoataion was selected: \(String(describing: view.annotation?.subtitle))")

    }
    
    private func mapView(mapView: MKMapView, didSelectAnnotationView view: MKAnnotationView) {
        print("test")
        
    }
    
}
