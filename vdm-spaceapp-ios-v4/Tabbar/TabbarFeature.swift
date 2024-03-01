//
//  TabbarFeature.swift
//  vdm-spaceapp-ios-v4
//
//  Created by Vattimo, Matteo (VDM) on 12/10/23.
//

import Foundation
import ComposableArchitecture
import UIKit

struct TabbarFeature: Reducer {
    struct State: Equatable {
        var dashboardState = DashboardFeature.State()
        var launchesState = LaunchesFeature.State(chosenType: 0)
    }
    
    enum Action: Equatable {
        case dashboardIconTapped
        case launchesIconTapped
    }
    
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .dashboardIconTapped:
            return .none
        case .launchesIconTapped:
            return .none
        }
    }
}
