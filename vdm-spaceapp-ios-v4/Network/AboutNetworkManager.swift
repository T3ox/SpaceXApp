//
//  LaunchpadNetworkManager.swift
//  vdm-spaceapp-ios-v4
//
//  Created by Vattimo, Matteo (VDM) on 13/10/23.
//

import Foundation
import ComposableArchitecture
import Dependencies

struct AboutNetworkManager {
    var fetchAbout: () async throws -> ApiCompanyInfo
}

extension AboutNetworkManager: DependencyKey {
    static let liveValue = Self(
        fetchAbout: APIAboutManager.fetchAbout
    )
}

struct APIAboutManager {
    static func fetchAbout() async throws -> ApiCompanyInfo {
        let url = URL(string: "https://api.spacexdata.com/v4/company")!
        let (data, _) = try await URLSession.shared.data(from: url)
        let results = try JSONDecoder().decode(ApiCompanyInfo.self, from: data)
        return results
    }
}

extension DependencyValues {
    var about: AboutNetworkManager {
        get { self[AboutNetworkManager.self] }
        set { self[AboutNetworkManager.self] = newValue }
    }
}
