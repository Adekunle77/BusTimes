//
//  StopAnnotationView.swift
//  BusTimes
//
//  Created by Ade Adegoke on 28/02/2019.
//  Copyright © 2019 AKA. All rights reserved.
//

import UIKit
import MapKit

class StopAnnotationView: UIView {
    
    @IBOutlet weak var busNumber: UILabel!
    @IBOutlet weak var arrivalTime: UILabel!
    @IBOutlet weak var busLocation: UILabel!
    @IBOutlet weak var busStopDistance: UILabel!
    @IBOutlet weak var didTapButton: UIButton!

    @IBAction func viewWillDisappear(_ sender: Any) {
        UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseOut, animations: {
            self.alpha = 0.0
        }, completion: { finished in
            self.removeFromSuperview()
        })
       
    }
}


