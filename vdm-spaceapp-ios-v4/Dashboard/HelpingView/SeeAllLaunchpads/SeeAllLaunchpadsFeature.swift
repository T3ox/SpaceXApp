//
//  SeeAllFacilitiesFeature.swift
//  vdm-spaceapp-ios-v4
//
//  Created by Vattimo, Matteo (VDM) on 13/10/23.
//

import Foundation
import ComposableArchitecture
import Dependencies

struct SeeAllLaunchpadsFeature: Reducer {
    struct State: Equatable {
        var launchpads = [Launchpad]()
        var stateList = LoadingState.idle
    }
    
    enum Action: Equatable {
        case updateListState
    }
    
    @Dependency(\.launchpad) var managerLaunchpad
    
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .updateListState:
            return .none
            
        }
    }
}

