//
//  AboutView.swift
//  vdm-spaceapp-ios-v4
//
//  Created by Vattimo, Matteo (VDM) on 25/10/23.
//

import SwiftUI
import ComposableArchitecture

struct AboutFeature: Reducer {
    struct State: Equatable {
        var aboutState = LoadingState.idle
        var companyInfo = CompanyInfo()
    }
    
    enum Action: Equatable {
        case fetchData
        case updateData(TaskResult<ApiCompanyInfo>)
    }
    
    @Dependency(\.about) var managerAbout
    
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .fetchData:
            state.aboutState = .progress
            return .run { send in
                await send(.updateData(TaskResult { try await managerAbout.fetchAbout() }))
            }
        case .updateData(.success(let companyInfo)):
            state.companyInfo = CompanyInfo(apiDataInfo: companyInfo)
            state.aboutState = .success
            return .none
        case .updateData(.failure(let error)):
            state.aboutState = .failed(error.localizedDescription)
            return .none
        }
    }
}
