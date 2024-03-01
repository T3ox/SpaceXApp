//
//  AboutView.swift
//  vdm-spaceapp-ios-v4
//
//  Created by Vattimo, Matteo (VDM) on 25/10/23.
//

import SwiftUI
import ComposableArchitecture

struct AboutView: View {
    let store: StoreOf<AboutFeature>
    
    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            NavigationView {
                List {
                    Group {
                        //FIRST SECTION
                        Section(header: HeaderView(title: "Board")) {
                            VStack {
                                GeometryView.rectanglePicture(founder: viewStore.companyInfo.founder)
                                HStack {
                                    GeometryView.squarePicture(alignment: .leading, who: viewStore.companyInfo.coo, role: "COO")
                                    Spacer()
                                    GeometryView.squarePicture(alignment: .trailing, who: viewStore.companyInfo.ctoPropulsion, role: "Propulsion CTO")
                                }
                            }
                            .listRowInsets(EdgeInsets(top: 5, leading: 0, bottom: 0, trailing: 0))
                            .padding(.bottom, 30)
                        }
                    
                        //SECOND SECTION
                        Section(header: HeaderView(title: "Company")) {
                            GeometryView.companyView(companyInfo: viewStore.companyInfo)
                        }
                    
                        //THIRD SECTION
                        Section(header: HeaderView(title: "Headquarters")) {
                            GeometryView.headquartersView(companyInfo: viewStore.companyInfo)
                                .listRowSeparator(.hidden)
                        }
                    }
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.visible, edges: .bottom)
                }
                .navigationTitle("About")
            }
            .onAppear { viewStore.send(.fetchData) }
        }
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView(store: .init(
            initialState: AboutFeature.State(),
            reducer: { AboutFeature() }))
    }
}
