//
//  Landpad.swift
//  vdm-spaceapp-ios-v4
//
//  Created by Vattimo, Matteo (VDM) on 24/10/23.
//

import Foundation

struct APILandpad: Decodable {
    var full_name: String
    var name: String
    var landing_attempts: Int
    var locality: String
    var region: String
}

struct Landpad: Codable, Equatable {
    var name: String
    var fullName: String
    var landingAttempts: Int
    var locality: String
    var region: String
    
    init() {
        name = ""
        fullName = ""
        landingAttempts = 0
        locality = ""
        region = ""
    }
    
    init(apiLandpadData: APILandpad) {
        name = apiLandpadData.name
        fullName = apiLandpadData.full_name
        landingAttempts = apiLandpadData.landing_attempts
        locality = apiLandpadData.locality
        region = apiLandpadData.region
    }
}
