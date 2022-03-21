//
//  BeerModel.swift
//  Punk Beer
//
//  Created by Cecil Costa on 19/03/2022.
//

import Foundation

struct BeerModel: Identifiable, Decodable {
    var id: Int
    var name: String
    var description: String
    var abv: Double
    var imageUrl: String
    var foodPairing: [String]
}
