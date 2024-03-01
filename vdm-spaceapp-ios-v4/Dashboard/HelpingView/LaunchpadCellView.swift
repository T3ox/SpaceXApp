//
//  LaunchpadCellView.swift
//  vdm-spaceapp-ios-v4
//
//  Created by Vattimo, Matteo (VDM) on 18/10/23.
//

import SwiftUI

struct LaunchpadCellView: View {
    var launchpad: Launchpad
    
    var body: some View {
        ZStack {
            Color.black
            VStack {
                VStack {
                    HStack {
                        Text(launchpad.locality)
                            .font(.headline)
                            .bold()
                            .fixedSize()
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text("STATUS")
                            .font(.footnote)
                    }.padding(.bottom, -10)
                    HStack {
                        Text(launchpad.name)
                            .font(.footnote)
                        Spacer()
                        Text(launchpad.status.capitalized)
                            .font(.headline)
                            .bold()
                            .fixedSize()
                            .frame(maxWidth: .infinity, alignment: .trailing)
                        switch launchpad.status {
                        case "active":
                            Circle()
                                .foregroundColor(.green)
                                .frame(width: 10, height: 10, alignment: .trailing)
                        case "retired":
                            Circle()
                                .foregroundColor(.red)
                                .frame(width: 10, height: 10, alignment: .trailing)
                        default:
                            Circle()
                                .foregroundColor(.orange)
                                .frame(width: 10, height: 10, alignment: .trailing)
                        }
                    }
                }
                Spacer()
                HStack {
                    LabelView(alignment: .leading, label: "REGION", value: launchpad.region)
                    Spacer()
                    LabelView(alignment: .center, label: "SUCCESS", value: String(launchpad.launchSuccesses))
                    Spacer()
                    LabelView(alignment: .trailing, label: "ATTEMPTS", value: String(launchpad.launchAttempts))
                }
                .padding(.top, 5)
            }
            .foregroundColor(.white)
            .padding(.init(top: 10, leading: 20, bottom: 10, trailing: 20))
            .background(LaunchpadImagesDownload(url: launchpad.imageUrl)
                .opacity(0.75)
                .alignmentGuide(.bottom, computeValue: { dimension in
                    dimension[VerticalAlignment.bottom]
                })
            )
        }
    }
    
    func LaunchpadImagesDownload(url: String) -> some View {
        AsyncImage(url: URL(string: (url))) { image in
            image.resizable()
        } placeholder: {
            ProgressView()
        }
    }
}

struct LaunchpadCellView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchpadCellView(launchpad: Launchpad(apiLaunchpadData: APILaunchpad()))
    }
}
