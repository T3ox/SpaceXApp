//
//  SatellitesView.swift
//  vdm-spaceapp-ios-v4
//
//  Created by Vattimo, Matteo (VDM) on 12/10/23.
//

import SwiftUI

struct StarlinkCountImageView: View {
    
    var starlinkCount: Int?
    var error: String?
    
    var body: some View {
        VStack {
            satelliteImage
            label
        }
        .background(
            Image("dashboard_satellites")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(20)
        )
        .foregroundColor(.white)
    }
    
    var satelliteImage: some View {
        Image("satellite-1")
            .resizable()
            .frame(width: 50, height: 50)
            .padding(.top, 20)
    }
    
    var label: some View {
        VStack {
            if error == nil {
                Group {
                    Text("There are currently ") +
                    Text("\(starlinkCount!)").bold() +
                    Text(" active Starlink satellites on the low Earth orbit.")
                }
                .multilineTextAlignment(.center)
                .lineLimit(nil)
                .padding(.init(top: 10, leading: 30, bottom: 10, trailing: 30))
            } else {
                Text(error!)
                    .multilineTextAlignment(.center)
                    .lineLimit(nil)
                    .padding(.init(top: 10, leading: 30, bottom: 0, trailing: 30))
            }
        }
    }
}

struct StarlinkCountImageView_Previews: PreviewProvider {
    static var previews: some View {
        StarlinkCountImageView(starlinkCount: 20, error: nil)
    }
}
