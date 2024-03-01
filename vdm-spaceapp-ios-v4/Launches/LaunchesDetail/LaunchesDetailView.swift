//
//  LaunchesDetailView.swift
//  vdm-spaceapp-ios-v4
//
//  Created by Vattimo, Matteo (VDM) on 23/10/23.
//

import SwiftUI
import ComposableArchitecture

struct LaunchesDetailView: View {
    let store: StoreOf<LaunchesDetailFeature>
    
    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            List {
                Section(
                    header: HeaderView(title: "Mission Patch")) {
                        imageDownload(url: viewStore.sendingLaunch.links?.patch?.large ?? "", width: 90, height: 90)
                    }
                    .listRowBackground(Color.clear)
                    .listSectionSeparator(.visible, edges: .bottom)
                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))

                Section(
                    header: HeaderView(title: "Rocket")) {
                        VStack(alignment: .leading) {
                            createRocket(ImagesURL: viewStore.sendingLaunch.rocket.flickr_images, labels: ["Rocket", "Fairings", "Booster"])
                        }
                    }
                    .listRowBackground(Color.clear)
                    .listSectionSeparator(.visible, edges: .bottom)
                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 30, trailing: 0))

                Section(
                    header: HeaderView(title: "Payload")) {
                        createPayload(data: viewStore.payload)
                    }
                    .listRowBackground(Color.clear)
                    .listSectionSeparator(.visible, edges: .bottom)

                Section(
                    header: HeaderView(title: "Launchpad")) {
                        createLaunchpad(launch: viewStore.sendingLaunch)
                    }
                    .listRowBackground(Color.clear)
                    .listSectionSeparator(.visible, edges: .bottom)

                Section(
                    header: HeaderView(title: "Landpad")) {
                        createLandpad(data: viewStore.landpad)
                    }
                    .listSectionSeparator(.visible, edges: .bottom)
            }
            .onAppear {
                viewStore.send(.fetchPayload)
                viewStore.send(.fetchLandpad)
            }
            .navigationTitle(viewStore.sendingLaunch.name)
        }
    }
    
    private func createRocket(ImagesURL arrayOfImages: [String], labels: [String]) -> some View {
        HStack {
            ForEach(labels.indices, id: \.self) { index in
                VStack(alignment: .leading) {
                    Text(labels[index])
                        .font(.headline)
                        .bold()
                    imageDownload(url: arrayOfImages[index], width: 100, height: 150)
                }
                if index != 2 {
                    Spacer() }
            }
        }
    }
    
    private func createPayload(data: Payload) -> some View {
        ZStack  {
            Rectangle()
                .fill(Color.white)
                .cornerRadius(15)
            VStack {
                HStack {
                    LabelView(alignment: .leading, label: "TYPE", value: data.type)
                    Spacer()
                    LabelView(alignment: .trailing, label: "CUSTOMER", value: data.customers ?? "None")
                }
                Spacer()
                HStack {
                    LabelView(alignment: .leading, label: "MASS", value: "\(String(data.massKg?.rounded(toPlaces: 0) ?? 0.0))Kg (\(String(data.massLbs?.rounded(toPlaces: 0) ?? 0.0))Lbs)")
                    Spacer()
                    LabelView(alignment: .trailing, label: "ORBIT", value: data.orbit)
                }
            }
            .padding(15)
        }
        .padding(.bottom, 30)
        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
    }
    
    private func createLaunchpad(launch: Launch) -> some View {
        ZStack {
            Rectangle()
                .fill(Color.white)
                .cornerRadius(15)
            VStack(alignment: .leading) {
                LabelView(alignment: .leading, label: "NAME", value: launch.launchpad.fullName)
                Spacer()
                LabelView(alignment: .leading, label: "TIME (GMT-4)", value: launch.dateUTC)
                Spacer()
                HStack {
                    LabelView(alignment: .leading, label: "LOCATION", value: launch.launchpad.locality)
                    Spacer()
                    LabelView(alignment: .trailing, label: "REGION", value: launch.launchpad.region)
                }
            }
            .padding(15)
        }
        .padding(.bottom, 30)
        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))

    }
    
    private func createLandpad(data: Landpad) -> some View {
        VStack(alignment: .leading) {
            LabelView(alignment: .leading, label: "NAME", value: data.fullName)
            Spacer()
            HStack {
                LabelView(alignment: .leading, label: "LANDINGS", value: String(data.landingAttempts))
                Spacer()
                LabelView(alignment: .trailing, label: "ABBREVIATION", value: String(data.name))
            }
            Spacer()
            HStack{
                LabelView(alignment: .leading, label: "LOCATION", value: data.locality)
                Spacer()
                LabelView(alignment: .trailing, label: "REGION", value: data.region)
            }
            Spacer()
        }
    }

}

struct LaunchesDetailView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchesDetailView(store: .init(
            initialState: LaunchesDetailFeature.State(sendingLaunch: Launch()),
            reducer: { LaunchesDetailFeature() }))
    }
}
