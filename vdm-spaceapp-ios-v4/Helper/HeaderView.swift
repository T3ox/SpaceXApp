//
//  HeaderView.swift
//  vdm-spaceapp-ios-v4
//
//  Created by Vattimo, Matteo (VDM) on 24/10/23.
//

import SwiftUI

struct HeaderView: View {
    var title: String
    
    var body: some View {
        Text(title)
            .font(.title)
            .bold()
            .textCase(nil)
            .padding(.vertical, -5)
            .foregroundColor(.black)
            .listRowInsets(EdgeInsets(top: 20, leading: 0, bottom: 20, trailing: 0))
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView(title: "Header")
    }
}
