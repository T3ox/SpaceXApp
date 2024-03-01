//
//  LaunchesListView.swift
//  vdm-spaceapp-ios-v4
//
//  Created by Vattimo, Matteo (VDM) on 23/10/23.
//

import SwiftUI

struct LaunchesListView: View {
    var array = [Launch]()
    
    var body: some View {
        List {
            ForEach(array) { launch in
                LaunchCellView(missionNameLbl: launch.name,
                               flightLbl: String(launch.flightNumber),
                               rocketLbl: launch.rocket.name,
                               launchpadLbl: launch.launchpad.name,
                               timeUTCLbl: launch.dateUTC,
                               state: launch.success
                )
                .if(launch.success == true) { $0.background (NavigationLink(destination: {
                    LaunchesDetailView(store: .init(
                        initialState: LaunchesDetailFeature.State(sendingLaunch: launch),
                        reducer: { LaunchesDetailFeature() }
                    ))
                },label: { Text("") })) }
            }
            .listRowSeparator(.hidden)
            .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
            .padding(.bottom)
            .listStyle(.plain)
        }
        .scrollContentBackground(.hidden)
    }
}

struct LaunchesListView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchesListView(array: [Launch(), Launch()])
    }
}
