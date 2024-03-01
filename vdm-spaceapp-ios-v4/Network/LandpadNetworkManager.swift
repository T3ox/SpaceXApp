//
//  StarlinkNetworkManager.swift
//  vdm-spaceapp-ios-v4
//
//  Created by Vattimo, Matteo (VDM) on 17/10/23.
//

import Foundation
import ComposableArchitecture
import Dependencies

struct LandpadNetworkManager {
    var fetchLandpad: (String) async throws -> Landpad
}

extension LandpadNetworkManager: DependencyKey {
    static let liveValue = Self(
        fetchLandpad: APILandpadManager.fetchLandpad
    )
}

struct APILandpadManager {
    static func fetchLandpad(id: String) async throws -> Landpad {
        let url = URL(string: "https://api.spacexdata.com/v4/landpads/\(id)")!
        var landpadToReturn = Landpad()
        
        do {
            let (data, _) = try await URLSession.shared
                .data(from: url)
            let result = try JSONDecoder().decode(APILandpad.self, from: data)
            landpadToReturn = Landpad(apiLandpadData: result)
        } catch {
            fatalError(error.localizedDescription)
        }
        return landpadToReturn
    }
}

extension DependencyValues {
    var landpad: LandpadNetworkManager {
        get { self[LandpadNetworkManager.self] }
        set { self[LandpadNetworkManager.self] = newValue }
    }
}


