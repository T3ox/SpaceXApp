//
//  LaunchesDetailFeature.swift
//  vdm-spaceapp-ios-v4
//
//  Created by Vattimo, Matteo (VDM) on 23/10/23.
//

import Foundation
import ComposableArchitecture
import Dependencies

struct LaunchesDetailFeature: Reducer {
    struct State: Equatable {
        var detailState = LoadingState.idle
        var sendingLaunch: Launch
        var payload = Payload()
        var landpad = Landpad()
    }
    
    enum Action: Equatable {
        case updatState
        case fetchPayload
        case updatePayload(Payload)
        case fetchLandpad
        case updateLandpad(Landpad)
    }
    
    @Dependency(\.payloads) var managerPayload
    @Dependency(\.landpad) var managerLandpad
    
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .updatState:
            state.detailState = .progress
            return .none
            
        //fetching Payload
        case .fetchPayload:
            let id = state.sendingLaunch.payloads.first!
            return .run { send in
                try await send(.updatePayload(managerPayload.fetchPayload(id)))
            }
        case .updatePayload(let payload):
            state.payload = payload
            return .none
            
        //fetching Landpad
        case .fetchLandpad:
            let id = (state.sendingLaunch.cores.first?.landpad)!
            return .run { send in
                try await send(.updateLandpad(managerLandpad.fetchLandpad(id)))
            }
        case .updateLandpad(let landpad):
            state.landpad = landpad
            return .none
        }
    }
}

