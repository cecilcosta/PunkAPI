//
//  BeerServiceRestfullRequestTest.swift
//  Punk BeerTests
//
//  Created by Cecil Costa on 21/03/2022.
//

import XCTest
@testable import Punk_Beer

class BeerServiceRestfullRequestTest: XCTestCase {

    override func setUpWithError() throws {
       
    }

    override func tearDownWithError() throws {
        
    }

    func testRequestPage1() throws {
        let expectation = expectation(description: "testIsDone")
        let beerServiceRestfulLocal = BeerServiceRestfulLocal()
        let configuration = BeerServiceConfiguration(page: 1, abvType: .all)
        Task {
            let beers = try await beerServiceRestfulLocal.fetchBeers(configuration)
            XCTAssertNotNil(beers)
            XCTAssertEqual(beers!.count, 4)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 3000)
    }

}
