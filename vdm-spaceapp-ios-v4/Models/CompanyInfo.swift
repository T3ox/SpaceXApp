//
//  PAYLOAD.swift
//  vdm-spaceapp-ios-v4
//
//  Created by Vattimo, Matteo (VDM) on 24/10/23.
//

import Foundation

struct ApiCompanyInfo: Codable, Equatable {
    let headquarters: Headquarters
    let links: CompanyLinks
    let name: String
    let founder: String
    let ceo: String
    let cto: String
    let coo: String
    let cto_propulsion: String
    let founded: Int
    let employees: Int
    let vehicles: Int
    let launch_sites: Int
    let test_sites: Int
    let valuation: Double
    let summary: String
}

struct CompanyInfo: Codable, Equatable {
    var headquarters: Headquarters
    var links: CompanyLinks
    var name: String
    var founder: String
    var ceo: String
    var coo: String
    var cto: String
    var ctoPropulsion: String
    var founded: Int
    var employees: Int
    var vehicles: Int
    var launchSites: Int
    var testSites: Int
    var valuation: Double
    var summary: String
    
    init() {
        self.headquarters = Headquarters(address: "", city: "", state: "")
        self.links = CompanyLinks(website: "", flickr: "", twitter: "")
        self.name = ""
        self.founder = ""
        self.ceo = ""
        self.coo = ""
        self.cto = ""
        self.ctoPropulsion = ""
        self.founded = 0
        self.employees = 0
        self.vehicles = 0
        self.launchSites = 0
        self.testSites = 0
        self.valuation = 0.0
        self.summary = ""
    }
    
    init(apiDataInfo: ApiCompanyInfo) {
        self.headquarters = apiDataInfo.headquarters
        self.links = apiDataInfo.links
        self.name = apiDataInfo.name
        self.founder = apiDataInfo.founder
        self.ceo = apiDataInfo.ceo
        self.coo = apiDataInfo.coo
        self.cto = apiDataInfo.cto
        self.ctoPropulsion = apiDataInfo.cto_propulsion
        self.founded = apiDataInfo.founded
        self.employees = apiDataInfo.employees
        self.vehicles = apiDataInfo.vehicles
        self.launchSites = apiDataInfo.launch_sites
        self.testSites = apiDataInfo.test_sites
        self.valuation = apiDataInfo.valuation
        self.summary = apiDataInfo.summary
    }
    
}

struct CompanyLinks: Codable, Equatable {
    let website: String
    let flickr: String
    let twitter: String
}
