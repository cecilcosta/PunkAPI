//
//  BeerService.swift
//  Punk Beer
//
//  Created by Cecil Costa on 19/03/2022.
//

import Foundation

protocol BeerService {
    func fetchBeers(_ configuration: BeerServiceConfiguration) async throws -> [BeerModel]?
    func url(for configuration: BeerServiceConfiguration) -> URL?
}
