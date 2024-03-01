//
//  launchpadListView.swift
//  vdm-spaceapp-ios-v4
//
//  Created by Vattimo, Matteo (VDM) on 18/10/23.
//

import SwiftUI

struct LaunchpadListView: View {
    var launchpadsArr = [Launchpad]()
    var error: String?
    var numberOfCells: Int?
    private var count: Int {
        return numberOfCells ?? launchpadsArr.count
    }
    
    var body: some View {
        if error == nil {
            VStack {
                ForEach(0..<count, id: \.self) { index in
                    LaunchpadCellView(launchpad: launchpadsArr[index])
                        .cornerRadius(20)
                        .padding(.horizontal, 15)
                }
            }
        } else {
            Text(error!)
        }
    }
}

struct launchpadListView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchpadListView()
    }
}
