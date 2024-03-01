//
//  StarlinkNetworkManager.swift
//  vdm-spaceapp-ios-v4
//
//  Created by Vattimo, Matteo (VDM) on 17/10/23.
//

import Foundation
import ComposableArchitecture
import Dependencies

struct PayloadNetworkManager {
    var fetchPayload: (String) async throws -> Payload
}

extension PayloadNetworkManager: DependencyKey {
    static let liveValue = Self(
        fetchPayload: APIPayloadManager.fetchPayload
    )
}

struct APIPayloadManager {
//    static var rocketsArr = [Rocket]()
//    static var rocketIds = [String]()
    
    static func fetchPayload(id: String) async throws -> Payload {
        let url = URL(string: "https://api.spacexdata.com/v4/payloads/\(id)")!
        var payloadToReturn: Payload = Payload()
        
        do {
            let (data, _) = try await URLSession.shared
                .data(from: url)
            let result = try JSONDecoder().decode(APIPayload.self, from: data)
            payloadToReturn = Payload(apiPayloadData: result)
        } catch {
            fatalError(error.localizedDescription)
        }
        return payloadToReturn
    }
    
//    static func checkRocketId(string toCheck: String) -> Rocket {
//        guard let index = self.rocketIds.firstIndex(of: toCheck) else { fatalError("Nessun Rocket trovato") }
//        return rocketsArr[index]
//    }
}

extension DependencyValues {
    var payloads: PayloadNetworkManager {
        get { self[PayloadNetworkManager.self] }
        set { self[PayloadNetworkManager.self] = newValue }
    }
}


