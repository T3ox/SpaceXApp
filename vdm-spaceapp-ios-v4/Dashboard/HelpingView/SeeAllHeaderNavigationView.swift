//
//  SeeAllHeaderNavigationView.swift
//  vdm-spaceapp-ios-v4
//
//  Created by Vattimo, Matteo (VDM) on 12/10/23.
//

import SwiftUI
import ComposableArchitecture

struct SeeAllHeaderNavigationView: View {
    let store: StoreOf<DashboardFeature>
    
    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            HStack {
                Text("Launch Facilities")
                    .fontWeight(.bold)
                    .font(.body)
                Spacer()
                NavigationLink(destination: SeeAllLaunchpadsView(store: .init(
                                    initialState: SeeAllLaunchpadsFeature.State(launchpads: viewStore.launchpadsData),
                                    reducer: { SeeAllLaunchpadsFeature() }
                                )))
                { Text("See All") }
            }
            .padding(.horizontal, 15)
        }
    }
}

struct SeeAllHeaderNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        SeeAllHeaderNavigationView(store: .init(
            initialState: DashboardFeature.State(), reducer: {
                DashboardFeature()
            }))
    }
}
