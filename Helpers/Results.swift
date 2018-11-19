//
//  Results.swift
//  BusTimes
//
//  Created by Ade Adegoke on 15/11/2018.
//  Copyright © 2018 AKA. All rights reserved.
//

import Foundation

enum Results <DataType, ErrorType: Error> {
    case success(DataType)
    case failure(ErrorType)
}
