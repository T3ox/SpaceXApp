//
//  DashboardFeature.swift
//  vdm-spaceapp-ios-v4
//
//  Created by Vattimo, Matteo (VDM) on 12/10/23.
//

import Foundation
import ComposableArchitecture

struct DashboardFeature: Reducer {
    struct State: Equatable {
        var starlinkCount = 0
        var launchpadsData = [Launchpad]()
        var stateStarlinks = LoadingState.idle
        var stateLaunchpads = LoadingState.idle
    }
    
    enum Action: Equatable {
        case fetchStarlink
        case starlinksReponse(TaskResult<[Starlink]>)
        case fetchLaunchpad
        case updateLaunchpad(TaskResult<[Launchpad]>)
    }
    
    @Dependency(\.starlinks) var managerStarlink
    @Dependency(\.launchpad) var managerLaunchpads
    
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .fetchStarlink:
            state.stateStarlinks = .progress
            return .run { send in
                await send(.starlinksReponse(TaskResult { try await managerStarlink.fetchStarlink() }))
            }
        case .starlinksReponse(.success(let starlinks)):
            state.starlinkCount = starlinks.count
            state.stateStarlinks = .success
            return .none
        case .starlinksReponse(.failure(let error)):
            state.stateStarlinks = .failed(error.localizedDescription)
            return .none
        case .fetchLaunchpad:
            state.stateLaunchpads = .progress
            return .run { send in
                await send(.updateLaunchpad(TaskResult { try await managerLaunchpads.fetchLaunchpads() }))
            }
        case .updateLaunchpad(.success(let launchpads)):
            state.launchpadsData = launchpads
            state.stateLaunchpads = .success
            return .none
        case .updateLaunchpad(.failure(let error)):
            state.stateLaunchpads = .failed(error.localizedDescription)
            return .none
        }
    }
}
