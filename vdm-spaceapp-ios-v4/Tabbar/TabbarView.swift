//
//  TabbarView.swift
//  vdm-spaceapp-ios-v4
//
//  Created by Vattimo, Matteo (VDM) on 12/10/23.
//

import SwiftUI
import ComposableArchitecture

struct TabbarView: View {
    let store: StoreOf<TabbarFeature>
    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            TabView {
                DashboardView(store: .init(
                    initialState: DashboardFeature.State(), reducer: {
                        DashboardFeature()
                    }))
                .tabItem {
                    Label("Dashboard", image: "tab_bar_dashboard")
                }
                LaunchesView(store: .init(
                    initialState: LaunchesFeature.State(chosenType: 0),
                    reducer: { LaunchesFeature() }))
                .tabItem {
                    Label("Launches", image: "tab_bar_launches")
                }
                AboutView(store: .init(
                    initialState: AboutFeature.State(),
                    reducer: { AboutFeature() }))
                .tabItem {
                    Label("About", image: "tab_bar_about")
                }
            }
            .onAppear() {
                let tabView = UITabBarAppearance()
                tabView.configureWithOpaqueBackground()
                UITabBar.appearance().scrollEdgeAppearance = tabView
            }
        }
    }
}

struct TabbarView_Previews: PreviewProvider {
    static var previews: some View {
        TabbarView(store: .init(
            initialState: TabbarFeature.State(),
            reducer: { TabbarFeature() }
        ))
    }
}
