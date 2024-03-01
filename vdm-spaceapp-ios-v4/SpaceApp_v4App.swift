//
//  vdm_spaceapp_ios_v4App.swift
//  vdm-spaceapp-ios-v4
//
//  Created by Vattimo, Matteo (VDM) on 12/10/23.
//

import SwiftUI

@main
struct vdm_spaceapp_ios_v4App: App {
    
    var body: some Scene {
        WindowGroup {
            TabbarView(store: .init(
                initialState: TabbarFeature.State(),
                reducer: { TabbarFeature() }
            ))
        }
    }
}
