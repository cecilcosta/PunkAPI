//
//  BeerServiceRestfulLocal.swift
//  Punk BeerTests
//
//  Created by Cecil Costa on 20/03/2022.
//

import Foundation
@testable import Punk_Beer

// just for mocking the URL
class BeerServiceRestfulLocal: BeerServiceRestful {
    override func url(for configuration: BeerServiceConfiguration) -> URL? {
        switch (configuration.page, configuration.abvType) {
            
        case (1, .all):
           
            return  Bundle(for: BeerServiceRestfulLocal.self).url(forResource: "Page1AllAbv", withExtension: "json")
        case (_, _):
            return nil
        }
    }
}
