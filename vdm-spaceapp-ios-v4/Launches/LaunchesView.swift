//
//  LaunchesView.swift
//  vdm-spaceapp-ios-v4
//
//  Created by Vattimo, Matteo (VDM) on 12/10/23.
//

import SwiftUI
import ComposableArchitecture

struct LaunchesView: View {
    let store: StoreOf<LaunchesFeature>
    
    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            NavigationView {
                VStack {
                    Picker("Type of launches", selection: viewStore.$chosenType) {
                        Text("Upcoming").tag(0)
                        Text("Past").tag(1)
                    }
                    .pickerStyle(.segmented)
                    .padding([.horizontal, .top])
                    switch viewStore.launchesState {
                    case .idle:
                        Spacer()
                        EmptyView()
                    case .progress:
                        Spacer()
                        ProgressView()
                        Spacer()
                    case .success:
                        if viewStore.chosenType == 0 { LaunchesListView(array: viewStore.upcomingLaunches) }
                        else { LaunchesListView(array: viewStore.pastLaunches) }
                    case .failed:
                        Text("Failed to load LaunchesData")
                    }
                }
                .navigationTitle("Launches")
            }
            .onAppear {
                viewStore.send(.fetchRocket)
                viewStore.send(.fetchLaunches)
            }
        }
    }
}

struct LaunchesView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchesView(store: .init(
            initialState: LaunchesFeature.State(chosenType: 0),
            reducer: { LaunchesFeature() }
        ))
    }
}
