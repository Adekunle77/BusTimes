//
//  BusInfoScreenCell.swift
//  BusTimes
//
//  Created by Ade Adegoke on 15/11/2018.
//  Copyright © 2018 AKA. All rights reserved.
//

import UIKit

class BusInfoScreenCell: UICollectionViewCell {

    @IBOutlet weak var busNumber: UILabel!
    @IBOutlet weak var arrivalTime: UILabel!
    @IBOutlet weak var busLocation: UILabel!
    @IBOutlet weak var busStopDistance: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
