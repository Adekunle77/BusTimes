//
//  AddRemoveExtension.swift
//  BusTimes
//
//  Created by Ade Adegoke on 23/01/2019.
//  Copyright © 2019 AKA. All rights reserved.
//

import UIKit

extension UIViewController {

    func add(_ child: UIViewController) {
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }

    func remove() {
        guard parent != nil else { return }
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
}



