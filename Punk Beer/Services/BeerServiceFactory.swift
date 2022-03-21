//
//  BeerServiceFactory.swift
//  Punk Beer
//
//  Created by Cecil Costa on 19/03/2022.
//

import Foundation

struct BeerServiceFactory {
    
    enum ServiceTypes {
        case restful
    }
    
    static func service(for serviceType: ServiceTypes) -> BeerService {
        switch serviceType {
        case .restful:
            return BeerServiceRestful()
        // as the enumeration is frozen, we don't need to add an @unkown default,
        // but I leave the switch for forcing the compiler to fail if a new enumeration is added.
        }
    }
}
