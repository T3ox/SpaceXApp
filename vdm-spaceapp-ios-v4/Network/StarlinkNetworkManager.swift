//
//  StarlinkNetworkManager.swift
//  vdm-spaceapp-ios-v4
//
//  Created by Vattimo, Matteo (VDM) on 17/10/23.
//

import Foundation
import ComposableArchitecture
import Dependencies

struct StarlinkNetworkManager {
    var fetchStarlink: () async throws -> [Starlink]
}

extension StarlinkNetworkManager: DependencyKey {
    static let liveValue = Self(
        fetchStarlink: {
            let url = URL(string: "https://api.spacexdata.com/v4/starlink")!
            var starlinksArr = [Starlink]()
            
            do {
                let (data, _) = try await URLSession.shared
                    .data(from: url)
                starlinksArr = try JSONDecoder().decode([Starlink].self, from: data)
                
            } catch {
                fatalError(error.localizedDescription)
            }
            return starlinksArr
        }
    )
}

extension DependencyValues {
    var starlinks: StarlinkNetworkManager {
        get { self[StarlinkNetworkManager.self] }
        set { self[StarlinkNetworkManager.self] = newValue }
    }
}
