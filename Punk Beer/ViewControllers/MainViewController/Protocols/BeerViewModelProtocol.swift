//
//  BeerViewModelProtocol.swift
//  Punk Beer
//
//  Created by Cecil Costa on 20/03/2022.
//

import Foundation
import UIKit

protocol BeerViewModelProtocol {
    
    var delegate: BeerViewModelDelegate? { get set }
    var beerName: String { get }
    
    var abvAbreviation: String { get }
    var abvColour: UIColor { get }
    
    func loadPicture()
}
