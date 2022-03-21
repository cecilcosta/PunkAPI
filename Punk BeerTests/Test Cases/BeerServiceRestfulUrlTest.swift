//
//  BeerServiceRestfulTest.swift
//  Punk BeerTests
//
//  Created by Cecil Costa on 20/03/2022.
//

import XCTest
@testable import Punk_Beer

class BeerServiceRestfulTest: XCTestCase {

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func testBasicUrlPage1() throws {
        let beerService = BeerServiceRestful()
        let configuration = BeerServiceConfiguration(page: 1, abvType: .all)
        let url = beerService.url(for: configuration)
        let expectedUrl = URL(string: "https://api.punkapi.com/v2/beers?page=1")
        XCTAssertNotNil(url)
        // Just to clarify, I don't like using unsafe unwrapping, but on unit tests they are
        // a good choise, becase if blow up the test it means that something is wrong here, and
        // it is tome to fix it.
        XCTAssertEqual(url!, expectedUrl!)
    }
    
    func testBasicUrlPage2() throws {
        let beerService = BeerServiceRestful()
        let configuration = BeerServiceConfiguration(page: 2, abvType: .all)
        let url = beerService.url(for: configuration)
        let expectedUrl = URL(string: "https://api.punkapi.com/v2/beers?page=2")
        XCTAssertNotNil(url)
        XCTAssertEqual(url!, expectedUrl!)
    }
    
    func testLowAbvUrlPage1() throws {
        let beerService = BeerServiceRestful()
        let configuration = BeerServiceConfiguration(page: 1, abvType: .low)
        let url = beerService.url(for: configuration)
        let expectedUrl = URL(string: "https://api.punkapi.com/v2/beers?page=1&abv_lt=6.0")
        XCTAssertNotNil(url)
        XCTAssertEqual(url!, expectedUrl!)
    }
    
    func testMediumAbvUrlPage1() throws {
        let beerService = BeerServiceRestful()
        let configuration = BeerServiceConfiguration(page: 1, abvType: .medium)
        let url = beerService.url(for: configuration)
        let expectedUrl = URL(string: "https://api.punkapi.com/v2/beers?page=1&abv_gt=6.0&abv_lt=10.0")
        XCTAssertNotNil(url)
        XCTAssertEqual(url!, expectedUrl!)
    }
    
    func testHighAbvUrlPage1() throws {
        let beerService = BeerServiceRestful()
        let configuration = BeerServiceConfiguration(page: 1, abvType: .high)
        let url = beerService.url(for: configuration)
        let expectedUrl = URL(string: "https://api.punkapi.com/v2/beers?page=1&abv_gt=10.0")
        XCTAssertNotNil(url)
        XCTAssertEqual(url!, expectedUrl!)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
