//
//  View+ext.swift
//  vdm-spaceapp-ios-v4
//
//  Created by Vattimo, Matteo (VDM) on 23/10/23.
//

import Foundation

extension Double {
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
