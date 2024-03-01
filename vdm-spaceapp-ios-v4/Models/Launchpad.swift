//
//  Launchpad.swift
//  vdm-spaceapp-ios-v4
//
//  Created by Vattimo, Matteo (VDM) on 12/10/23.
//

import Foundation

struct APILaunchpad: Codable, Identifiable {
    let name: String
    let full_name: String
    let locality: String
    let region: String
    let launch_attempts: Int
    let launch_successes: Int
    let status: String
    let images: Images
    let id: String
    
    init() {
        self.id = "0"
        self.name = "VAFB SLC 3W"
        self.full_name = "Vandenberg Space Force Base Space Launch Complex 3W"
        self.region = "California"
        self.locality = "Vandenberg Space Force Base<"
        self.status = "retired"
        self.launch_attempts = 99
        self.launch_successes = 97
        self.images = Images(large: [])
    }
}

struct Launchpad: Identifiable, Equatable, Codable {
    var id: String
    var name: String
    var fullName: String
    var region: String
    var locality: String
    var status: String
    var launchAttempts: Int
    var launchSuccesses: Int
    var imageUrl: String
    
    init(apiLaunchpadData: APILaunchpad) {
        self.id = apiLaunchpadData.id
        self.name = apiLaunchpadData.name
        self.fullName = apiLaunchpadData.full_name
        self.region = apiLaunchpadData.region
        self.locality = apiLaunchpadData.locality
        self.status = apiLaunchpadData.status
        self.launchAttempts = apiLaunchpadData.launch_attempts
        self.launchSuccesses = apiLaunchpadData.launch_successes
        self.imageUrl = apiLaunchpadData.images.large.first ?? ""
    }
}

struct Images: Codable {
    var large: [String]
}
