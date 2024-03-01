//
//  LabelView.swift
//  vdm-spaceapp-ios-v4
//
//  Created by Vattimo, Matteo (VDM) on 18/10/23.
//

import SwiftUI

public enum LoadingState: Equatable {
    case idle
    case progress
    case success
    case failed(String)
}
