//
//  Launch.swift
//  vdm-spaceapp-ios-v4
//
//  Created by Vattimo, Matteo (VDM) on 20/10/23.
//

import Foundation

struct APILaunch: Codable, Equatable {
    var name: String
    var flight_number: Int
    var rocket: String
    var launchpad: String
    var date_utc: String
    var success: Bool?
    var payloads: [String]
    var cores: [Core]
    var links: Links?
    
    init() {
        self.name = "Crew-5"
        flight_number = 187
        rocket = ""
        launchpad = ""
        date_utc = "5 ott 2022, 04:00 PM"
        success = true
        payloads = ["62dd73ed202306255024d145"]
        cores = [Core(core: "633d9da635a71d1d9c66797b", landpad: "5e9e3033383ecbb9e534e7cc")]
        links = Links(patch: Patch(large: "https://images2.imgbox.com/33/2e/k6VE4iYl_o.png",
                                   small: "https://images2.imgbox.com/eb/d8/D1Yywp0w_o.png"))
    }
}

struct Launch: Identifiable, Equatable {
    var name: String
    var flightNumber: Int
    var dateUTC: String
    var rocket: Rocket
    var launchpad: Launchpad
    var success: Bool?
    var payloads: [String]
    var cores: [Core]
    var links: Links?
    let id = UUID()
    
    init() {
        self.name = "Crew-5"
        flightNumber = 187
        rocket = Rocket(name: "", flickr_images: [""], id: "")
        launchpad = Launchpad(apiLaunchpadData: APILaunchpad())
        dateUTC = "5 ott 2022, 04:00 PM"
        success = true
        payloads = ["62dd73ed202306255024d145"]
        cores = [Core(core: "633d9da635a71d1d9c66797b", landpad: "5e9e3033383ecbb9e534e7cc")]
        links = Links(patch: Patch(large: "https://images2.imgbox.com/33/2e/k6VE4iYl_o.png",
                                   small: "https://images2.imgbox.com/eb/d8/D1Yywp0w_o.png"))
    }
    
    init(apiLaunchData: APILaunch, apiRocket: Rocket, apiLaunchpad: Launchpad, apiDateTime: String) {
        name = apiLaunchData.name
        flightNumber = apiLaunchData.flight_number
        rocket = apiRocket
        launchpad = apiLaunchpad
        dateUTC = apiDateTime
        success = apiLaunchData.success
        payloads = apiLaunchData.payloads
        cores = apiLaunchData.cores
        links = apiLaunchData.links
        
    }
}
