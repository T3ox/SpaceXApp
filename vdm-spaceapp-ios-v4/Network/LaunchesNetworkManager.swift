//
//  LaunchesNetworkManager.swift
//  vdm-spaceapp-ios-v4
//
//  Created by Vattimo, Matteo (VDM) on 20/10/23.
//

import Foundation
import ComposableArchitecture
import Dependencies

struct LaunchesNetworkManager {
    var fetchLaunches: () async throws -> [APILaunch]
}

extension LaunchesNetworkManager: DependencyKey {
    static let liveValue = Self(
        fetchLaunches: {
            let url = URL(string: "https://api.spacexdata.com/v4/launches")!
            var launchesArr = [APILaunch]()
            
            do {
                let (data, _) = try await URLSession.shared
                    .data(from: url)
                launchesArr = try JSONDecoder().decode([APILaunch].self, from: data)
            }
            return launchesArr
        }
    )
}

extension DependencyValues {
    var launches: LaunchesNetworkManager {
        get { self[LaunchesNetworkManager.self] }
        set { self[LaunchesNetworkManager.self] = newValue }
    }
}
