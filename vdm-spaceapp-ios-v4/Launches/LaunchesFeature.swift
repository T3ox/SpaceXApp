//
//  LaunchesFeature.swift
//  vdm-spaceapp-ios-v4
//
//  Created by Vattimo, Matteo (VDM) on 12/10/23.
//

import Foundation
import ComposableArchitecture

struct LaunchesFeature: Reducer {
    struct State: Equatable {
        @BindingState var chosenType: Int
        var launchesState = LoadingState.idle
        var pastLaunches = [Launch]()
        var upcomingLaunches = [Launch]()
    }
    
    enum Action: Equatable, BindableAction {
        case binding(BindingAction<State>)
        case fetchRocket
        case fetchLaunches
        case updateLaunches(TaskResult<[APILaunch]>)
    }
    
    @Dependency(\.rocket) var managerRocket
    @Dependency(\.launchpad) var managerLaunchpad
    @Dependency(\.launches) var managerLaunch
    
    var body: some ReducerOf<LaunchesFeature> {
        BindingReducer()
        
        Reduce { state, action in
            switch action {
            case .binding(_):
                return .none
            case .fetchRocket:
                state.launchesState = .progress
                return .run { send in
                    try await managerRocket.fetchRockets()
                }
            case .fetchLaunches:
                return .run { send in
                    await send(.updateLaunches(TaskResult { try await managerLaunch.fetchLaunches() }))
                }
            case .updateLaunches(.success(let apiLaunchpad)):
                for launch in apiLaunchpad {
                    let tempRocket = managerRocket.checkId(launch.rocket)
                    let tempLaunchpad = managerLaunchpad.checkId(launch.launchpad)
                    let tempDate = dateTimeConverter(utcDateString: launch.date_utc)
                    let launchData = Launch(apiLaunchData: launch, apiRocket: tempRocket, apiLaunchpad: tempLaunchpad, apiDateTime: tempDate)
                    
                    if launchData.success == nil { state.upcomingLaunches.append(launchData) } else { state.pastLaunches.append(launchData) }
                    state.pastLaunches.reverse()
                    state.upcomingLaunches.sort { $0.flightNumber < $1.flightNumber }
                }
                state.launchesState = .success
                return .none
            case .updateLaunches(.failure(let error)):
                state.launchesState = .failed(error.localizedDescription)
                return .none
            }
        
        }
    }
}
