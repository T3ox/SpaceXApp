//
//  GeometryView.swift
//  vdm-spaceapp-ios-v4
//
//  Created by Vattimo, Matteo (VDM) on 25/10/23.
//

import SwiftUI

struct GeometryView {
    static func rectanglePicture(founder: String) -> some View {
        ZStack(alignment: .bottom) {
            RoundedRectangle(cornerRadius: 10)
                .aspectRatio(5/2.25, contentMode: .fit)
                .foregroundColor(.gray)
            HStack {
                LabelView(alignment: .leading, label: "NAME", value: founder)
                Spacer()
                LabelView(alignment: .trailing, label: "ROLE", value: "CEO, CTO & FOUNDER")
            }
            
//            VStack {
//                HStack(alignment: .bottom) {
//                    Text("NAME")
//                    Spacer()
//                    Text("ROLE")
//                }
//                .font(.footnote)
//                HStack {
//                    Text(founder)
//                    Spacer()
//                    Text("CEO, CTO & FOUNDER")
//                }
//                .font(.headline)
//                .bold()
//            }
            .foregroundColor(.white)
            .padding(.init(top: 0, leading: 15, bottom: 5, trailing: 20))
        }
    }
    
    static func squarePicture(alignment: HorizontalAlignment, who: String, role: String) -> some View {
        ZStack(alignment: .bottom) {
            RoundedRectangle(cornerRadius: 10)
                .aspectRatio(1/1, contentMode: .fit)
                .foregroundColor(.gray)
            VStack(alignment: alignment) {
                LabelView(alignment: .trailing, label: "NAME", value: who)
                .padding(.bottom, 5)
                LabelView(alignment: .trailing, label: "ROLE", value: role)
            }
            .foregroundColor(.white)
            .padding(.bottom, 10)
        }
    }

    static func companyView(companyInfo: CompanyInfo) -> some View {
        ZStack {
            Rectangle()
                .fill(Color.white)
                .cornerRadius(15)
            VStack(alignment: .leading) {
                HStack {
                    LabelView(alignment: .leading, label: "NAME", value: companyInfo.name)
                    Spacer()
                    LabelView(alignment: .center, label: "FOUNDED", value: String(companyInfo.founded))
                    Spacer()
                    LabelView(alignment: .trailing, label: "EMPLOYEES", value: String(companyInfo.founded))
                }
                Spacer()
                HStack {
                    LabelView(alignment: .leading, label: "VEHICLES", value: String(companyInfo.vehicles))
                    Spacer()
                    LabelView(alignment: .center, label: "LAUNCH SITES", value: String(companyInfo.launchSites))
                    Spacer()
                    LabelView(alignment: .trailing, label: "TEST SITES", value: String(companyInfo.testSites))
                }
                Spacer()
                Text("VALUE")
                    .font(.footnote)
                HStack {
                    Text("$ \(abbreviateNumber(companyInfo.valuation))")
                        .font(.headline)
                        .bold()
                    Spacer()
                    buttonLink(image: "link", fromSystem: true, link: companyInfo.links.website)
                    buttonLink(image: "circle.grid.2x1", fromSystem: true, link: companyInfo.links.flickr)
                    buttonLink(image: "twitter", fromSystem: false, link: companyInfo.links.twitter)
                }
                Spacer()
                Text("DESCRIPTION")
                    .font(.footnote)
                Text(companyInfo.summary)
                    .padding(.bottom, 10)
            }
            .padding(15)
        }
        .padding(.bottom, 30)
        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
    }
    
    static func buttonLink(image: String, fromSystem: Bool, link: String) -> some View {
        Link(destination: (URL(string: link) ?? URL(string: "https://www.apple.com")!)) {
            if fromSystem {
                Image(systemName: image)
                    .background(Color.gray
                        .frame(width: 25, height: 25, alignment: .trailing)
                        .cornerRadius(20))
            } else {
                Image(image)
                    .background(Color.gray
                        .frame(width: 25, height: 25, alignment: .trailing)
                        .cornerRadius(20))
            }
        }
        .buttonStyle(.plain)
    }
    
    static func headquartersView(companyInfo: CompanyInfo) -> some View {
        ZStack {
            Rectangle()
                .fill(Color.white)
                .cornerRadius(15)
            VStack(alignment: .leading) {
                Text("ADDRESS")
                    .font(.footnote)
                Text(companyInfo.headquarters.address)
                    .font(.headline)
                    .bold()
                Spacer()
                HStack {
                    Text("STATE")
                    Spacer()
                    Text("CITY")
                }
                .font(.footnote)
                
                HStack {
                    Text(companyInfo.headquarters.state)
                    Spacer()
                    Text(companyInfo.headquarters.city)
                }
                .font(.headline)
                .bold()
            }
            .padding(15)
        }
        .padding(.bottom, 30)
        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
    }
    
    private static func abbreviateNumber(_ number: Double) -> String {
        let abbreviations = ["", "K", "M", "B", "T"]
        var index = 0
        var num = number

        while num >= 1000.0 && index < abbreviations.count - 1 {
            num /= 1000.0
            index += 1
        }

        return String(format: "%.0f %@", num, abbreviations[index])
    }
    
}
