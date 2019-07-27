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

    private lazy var loadingView = LoadingViewController()
    
    @IBOutlet weak private var mapView: MKMapView!
    @IBOutlet weak var refreshButton: UIButton!
    fileprivate let label = UILabel()
    fileprivate var viewModel = BusInfoViewModel()
    private let reuseIdentifier = "MyIdentifier"
    private let identifier = "Identifier"
 
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(label)
        viewModelSetUp()
        add(loadingView)
        
    }

    override func viewWillAppear(_ animated: Bool) {
        viewModel.clearCurrentView()
    }

    func viewModelSetUp() {
        viewModel.delegate = self
        viewModel.addAnnotationTo(mapView: mapView)
    }

    @IBAction func getlatestBusInfo(_ sender: Any) {
        add(loadingView)
        viewModel.removeAnnotatonInfo(mapView: self.mapView)
        viewModel.getlatestBusInfo()
        viewModel.addAnnotationTo(mapView: mapView)
    }
  
    @objc func didDissSubView(sender: UIButton) {
        if view.isKind(of: AnnotationView.self) {
            for subview in view.subviews {
                subview.removeFromSuperview()
            }
        }
    }
}

extension BusInfoViewController: ViewModelDelegate {
    func modelDidupdate() {
        self.loadingView.remove()
    }
    
    func modelDidUpdateWithError(error: Error) {
       print(error.localizedDescription)
    }
}

extension BusInfoViewController: MKMapViewDelegate, UIPopoverPresentationControllerDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? PlaceAnnotation else { return nil }
        var annotationView: MKPinAnnotationView
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            for view in annotationView.subviews {
                view.removeFromSuperview()
            }
            annotationView.canShowCallout = false
            annotationView.calloutOffset = CGPoint(x: -5, y: 5)
            let annotationLabel = UILabel(frame: CGRect(x: -60, y: -40, width: 125, height: 38))
            annotationLabel.numberOfLines = 3
            annotationLabel.textAlignment = .center
            annotationLabel.font = UIFont(name: "Rockwell", size: 9)

            let busNumber = annotation.busNumber
            let busArrivalTime = annotation.arrivalTime
            let direction = annotation.busDirection
            annotationLabel.text = "Next bus: \(busNumber)\n Arrives: \(busArrivalTime) \n Direction: \(direction)"
            annotationLabel.backgroundColor = .white
            annotationLabel.layer.cornerRadius = 0
            annotationLabel.clipsToBounds = true
            annotationView.addSubview(annotationLabel)
        
        return annotationView
    }

    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if view.annotation is MKUserLocation { return }
        guard let annotationViewInfo = view.annotation as? PlaceAnnotation else { return }
        let views = Bundle.main.loadNibNamed("StopAnnotationNib", owner: nil, options: nil)
        guard let calloutView = views?[0] as? StopAnnotationView else {return }
        calloutView.arrivalTime.text = annotationViewInfo.busNumber
        calloutView.center = CGPoint(x: -5, y: 5)
        view.bringSubviewToFront(calloutView)
        view.addSubview(calloutView)
        let selectedAnnotations = mapView.selectedAnnotations
        for annotation in selectedAnnotations {
            mapView.deselectAnnotation(annotation, animated: false)
        }
    }
}
