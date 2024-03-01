//
//  LaunchpadNetworkManager.swift
//  vdm-spaceapp-ios-v4
//
//  Created by Vattimo, Matteo (VDM) on 13/10/23.
//

import Foundation
import ComposableArchitecture
import Dependencies

struct RocketNetworkManager {
    var fetchRockets: () async throws -> Void
    var checkId: (String) -> Rocket
}

extension RocketNetworkManager: DependencyKey {
    static let liveValue = Self(
        fetchRockets: APIRocketManager.fetchRockets,
        checkId: APIRocketManager.checkRocketId
    )
}

struct APIRocketManager {
    static var rocketsArr = [Rocket]()
    static var rocketIds = [String]()
    
    static func fetchRockets() async throws -> Void {
        let url = URL(string: "https://api.spacexdata.com/v4/rockets")!
        
        do {
            let (data, _) = try await URLSession.shared
                .data(from: url)
            let results = try JSONDecoder().decode([Rocket].self, from: data)
            rocketsArr = results
            rocketsArr.forEach { rocket in
                rocketIds.append(rocket.id)
            }
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    static func checkRocketId(string toCheck: String) -> Rocket {
        guard let index = self.rocketIds.firstIndex(of: toCheck) else { fatalError("Nessun Rocket trovato") }
        return rocketsArr[index]
    }
}

extension DependencyValues {
    var rocket: RocketNetworkManager {
        get { self[RocketNetworkManager.self] }
        set { self[RocketNetworkManager.self] = newValue }
    }
}
