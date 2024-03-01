//
//  LabelView.swift
//  vdm-spaceapp-ios-v4
//
//  Created by Vattimo, Matteo (VDM) on 18/10/23.
//

import SwiftUI

struct LabelView: View {
    var alignment: HorizontalAlignment
    var label: String
    var value: String
    
    var body: some View {
        VStack(alignment: alignment) {
            Text(label).font(.footnote)
            Text(value).font(.headline).bold()
        }
    }
}

struct LabelView_Previews: PreviewProvider {
    static var previews: some View {
        LabelView(alignment: .leading, label: "Label", value: "Value")
    }
}
