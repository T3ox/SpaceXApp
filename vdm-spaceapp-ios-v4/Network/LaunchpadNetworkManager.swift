//
//  LaunchpadNetworkManager.swift
//  vdm-spaceapp-ios-v4
//
//  Created by Vattimo, Matteo (VDM) on 13/10/23.
//

import Foundation
import ComposableArchitecture
import Dependencies

struct LaunchpadNetworkManager {
    var fetchLaunchpads: () async throws -> [Launchpad]
    var checkId: (String) -> Launchpad
    var launchpadData = [Launchpad]()
}

extension LaunchpadNetworkManager: DependencyKey {
    static let liveValue = Self(
        fetchLaunchpads: APILaunchpadManager.fetchLaunchpads,
        checkId: APILaunchpadManager.checkLaunchpadId,
        launchpadData: APILaunchpadManager.launchpadsArr
    )
}

struct APILaunchpadManager {
    static var launchpadsArr = [Launchpad]()
    static var launchpadsIds = [String]()
    
    static func fetchLaunchpads() async throws -> [Launchpad] {
        let url = URL(string: "https://api.spacexdata.com/v4/launchpads")!
        
        do {
            let (data, _) = try await URLSession.shared
                .data(from: url)
            let results = try JSONDecoder().decode([APILaunchpad].self, from: data)
            results.forEach { launchpad in
                launchpadsArr.append(Launchpad(apiLaunchpadData: launchpad))
                launchpadsIds.append(launchpad.id)
            }
        } catch {
            fatalError(error.localizedDescription)
        }
        return launchpadsArr
    }
    
    static func checkLaunchpadId(string toCheck: String) -> Launchpad {
        guard let index = launchpadsIds.firstIndex(of: toCheck) else { fatalError("Nessun Launchpad trovato") }
        return launchpadsArr[index]
    }
}

extension DependencyValues {
    var launchpad: LaunchpadNetworkManager {
        get { self[LaunchpadNetworkManager.self] }
        set { self[LaunchpadNetworkManager.self] = newValue }
    }
}
