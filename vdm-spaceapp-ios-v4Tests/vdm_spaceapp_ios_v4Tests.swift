//
//  vdm_spaceapp_ios_v4Tests.swift
//  vdm-spaceapp-ios-v4Tests
//
//  Created by Vattimo, Matteo (VDM) on 12/10/23.
//

import XCTest
import ComposableArchitecture
import Dependencies
@testable import vdm_spaceapp_ios_v4

final class vdm_spaceapp_ios_v4Tests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    @MainActor
    func testExample() async throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
        let store = TestStore(initialState: DashboardFeature.State()) {
            DashboardFeature()
        }
        let launchStore = TestStore(initialState: LaunchesFeature.State(chosenType: 0)) {
            LaunchesFeature()
        }
        
        
        let starlinkModel = withDependencies {
            $0.starlinks = StarlinkNetworkManager(fetchStarlink: {
                return [Starlink(id: "bubu")]
            })
        } operation: {
            DashboardFeature()
        }

        let launchesModel = withDependencies {
            $0.launches = LaunchesNetworkManager(fetchLaunches: {
                return [APILaunch(), APILaunch()]
            })
        } operation: {
            LaunchesFeature()
        }
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
