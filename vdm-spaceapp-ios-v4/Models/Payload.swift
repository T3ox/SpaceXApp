//
//  PAYLOAD.swift
//  vdm-spaceapp-ios-v4
//
//  Created by Vattimo, Matteo (VDM) on 24/10/23.
//

import Foundation

struct APIPayload: Decodable {
    var type: String
    var customers: [String]
    var mass_kg: Double?
    var mass_lbs: Double?
    var orbit: String
}


struct Payload: Codable, Equatable {
    var type: String
    var customers: String?
    var massKg: Double?
    var massLbs: Double?
    var orbit: String
    
    init() {
        type = ""
        customers = ""
        massKg = 0.0
        massLbs = 0.0
        orbit = ""
    }
    
    init(apiPayloadData: APIPayload) {
        type = apiPayloadData.type
        customers = apiPayloadData.customers.first
        massKg = apiPayloadData.mass_kg
        massLbs = apiPayloadData.mass_lbs
        orbit = apiPayloadData.orbit
    }
    
    
}
