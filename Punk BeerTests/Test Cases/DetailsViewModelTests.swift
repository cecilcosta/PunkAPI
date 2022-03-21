//
//  DetailsViewModelTests.swift
//  Punk BeerTests
//
//  Created by Cecil Costa on 20/03/2022.
//

import XCTest
@testable import Punk_Beer

class DetailsViewModelTests: XCTestCase {

    override func setUpWithError() throws {
      
    }

    override func tearDownWithError() throws {
        
    }

    func testAbv35() throws {
        let beerModel = BeerModel(id: 1,
                                  name: "Karlsberg",
                                  description: "Green Beer",
                                  abv: 3.5,
                                  imageUrl: "http://www.picture.com/picture.jpg",
                                  foodPairing:  ["Bbq", "Salad", "Smart cereals"])
        let beerViewModel = DetailViewModel(beerModel: beerModel)
        XCTAssertEqual(beerViewModel.abvLevel, "Abv: 3.5%")
    }
    
    func testAbv42() throws {
        let beerModel = BeerModel(id: 1,
                                  name: "Karlsberg",
                                  description: "Green Beer",
                                  abv: 4.2,
                                  imageUrl: "http://www.picture.com/picture.jpg",
                                  foodPairing:  ["Bbq", "Salad", "Smart cereals"])
        let beerViewModel = DetailViewModel(beerModel: beerModel)
        XCTAssertEqual(beerViewModel.abvLevel, "Abv: 4.2%")
    }
    
    func testAbv60() throws {
        let beerModel = BeerModel(id: 1,
                                  name: "Karlsberg",
                                  description: "Green Beer",
                                  abv: 6,
                                  imageUrl: "http://www.picture.com/picture.jpg",
                                  foodPairing:  ["Bbq", "Salad", "Smart cereals"])
        let beerViewModel = DetailViewModel(beerModel: beerModel)
        XCTAssertEqual(beerViewModel.abvLevel, "Abv: 6.0%")
    }
    
    func testFood() throws {
        let beerModel = BeerModel(id: 1,
                                  name: "Karlsberg",
                                  description: "Green Beer",
                                  abv: 6,
                                  imageUrl: "http://www.picture.com/picture.jpg",
                                  foodPairing:  ["Bbq", "Salad", "Smart cereals"])
        let beerViewModel = DetailViewModel(beerModel: beerModel)
        XCTAssertEqual(beerViewModel.foodPairing, """
‣ Bbq
‣ Salad
‣ Smart cereals
""")
    }

   

}
