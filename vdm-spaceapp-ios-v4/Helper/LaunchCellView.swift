//
//  LaunchCellView.swift
//  vdm-spaceapp-ios-v4
//
//  Created by Vattimo, Matteo (VDM) on 23/10/23.
//

import SwiftUI

struct LaunchCellView: View {
    var missionNameLbl = "Failed to load"
    var flightLbl = "Failed to load"
    var rocketLbl = "Failed to load"
    var launchpadLbl = "Failed to load"
    var timeUTCLbl = "Failed to load"
    var state: Bool? = nil
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(DrawingConstants.cellColor)
            content
        }
        .cornerRadius(20)
        .foregroundColor(.white)
    }
    
    var content: some View {
        HStack {
            VStack(alignment: .leading) {
                LabelView(alignment: .leading, label: "MISSION NAME", value: missionNameLbl)
                Spacer()
                HStack {
                    LabelView(alignment: .leading, label: "FLIGHT", value: flightLbl)
                    Spacer()
                    LabelView(alignment: .trailing, label: "LAUNCHPAD", value: launchpadLbl)
                }
                Spacer()
                HStack {
                    LabelView(alignment: .leading, label: "ROCKET", value: rocketLbl)
                    Spacer()
                    LabelView(alignment: .trailing, label: "TIME(UTC)", value: timeUTCLbl)
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
            
            switch state {
            case true:
                Color.green
                    .frame(width: 15, height: 170, alignment: .trailing)
                    .padding(.trailing, 0)
                    .fixedSize()
            case false:
                Color.red
                    .frame(width: 15, height: 170, alignment: .trailing)
                    .padding(.trailing, 0)
                    .fixedSize()
            default:
                Color.clear
                    .frame(height: 170, alignment: .trailing)
                    .padding(.trailing, -15)
                    .fixedSize()
            }
        }
    }
    
    struct DrawingConstants {
        static let cornerRadius: CGFloat = 20
        static let cellColor = Color(red: 44/255, green: 44/255, blue: 44/255)
    }
    
    enum Success {
        case none
        case success
        case failed
    }
}

struct LaunchCellView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchCellView()
    }
}
