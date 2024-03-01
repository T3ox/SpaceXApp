//
//  DashboardView.swift
//  vdm-spaceapp-ios-v4
//
//  Created by Vattimo, Matteo (VDM) on 12/10/23.
//

import SwiftUI
import ComposableArchitecture

struct DashboardView: View {
    let store: StoreOf<DashboardFeature>
    
    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            NavigationView {
                VStack {
                    starlinkCountResponse
                    SeeAllHeaderNavigationView(store: store)
                    launchpadList
                }
                .onAppear {
                    Task {
                        viewStore.send(.fetchStarlink)
                        viewStore.send(.fetchLaunchpad)
                    }
                }
                .navigationTitle("Dashboard")
            }
        }
    }
    
    private var starlinkCountResponse: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            VStack {
                switch viewStore.stateStarlinks {
                case .idle:
                    EmptyView()
                case .progress:
                    ZStack {
                        StarlinkCountImageView(starlinkCount: viewStore.starlinkCount)
                            .hidden()
                        ProgressView()
                    }
                case .success:
                    StarlinkCountImageView(starlinkCount: viewStore.starlinkCount)
                case .failed:
                    StarlinkCountImageView(error: "Failed to download number of starlink")
                }
            }
            .padding(.bottom, 30)
        }
    }
    
    private var launchpadList: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            VStack {
                Spacer()
                switch viewStore.stateLaunchpads {
                case .idle:
                    EmptyView()
                case .progress:
                    ProgressView()
                case .success:
                    LaunchpadListView(launchpadsArr: viewStore.launchpadsData, numberOfCells: 3)
                case .failed:
                    LaunchpadListView(launchpadsArr: [Launchpad](), error: "Failed to load launchpad information")
                }
                Spacer()
            }
        }
    }
    
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView(store: .init(
            initialState: DashboardFeature.State(),
            reducer: { DashboardFeature() }))
    }
}
