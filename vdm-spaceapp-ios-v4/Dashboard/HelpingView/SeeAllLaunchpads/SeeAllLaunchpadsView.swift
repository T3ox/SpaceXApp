//
//  SeeAllFacilitiesView.swift
//  vdm-spaceapp-ios-v4
//
//  Created by Vattimo, Matteo (VDM) on 13/10/23.
//

import SwiftUI
import ComposableArchitecture

struct SeeAllLaunchpadsView: View {
    let store: StoreOf<SeeAllLaunchpadsFeature>
    
    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            List {
                Section {
                    LaunchpadListView(launchpadsArr: viewStore.launchpads)
                        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                }
            }
            .scrollContentBackground(.hidden)
            .padding(.horizontal, -25)
        }
        .navigationTitle("Launch Facilities")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct SeeAllFacilitiesView_Previews: PreviewProvider {
    static var previews: some View {
        SeeAllLaunchpadsView(store: .init(
            initialState: SeeAllLaunchpadsFeature.State(
                launchpads: [Launchpad(apiLaunchpadData: APILaunchpad()), Launchpad(apiLaunchpadData: APILaunchpad())]
                                                       ),
            reducer: { SeeAllLaunchpadsFeature() }
        ))
    }
}
