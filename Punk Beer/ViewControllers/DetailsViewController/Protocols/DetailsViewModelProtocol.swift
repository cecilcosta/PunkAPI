//
//  DetailsViewModelProtocol.swift
//  Punk Beer
//
//  Created by Cecil Costa on 20/03/2022.
//

import Foundation
import UIKit

protocol DetailsViewModelDelegate: AnyObject {
    func detailsViewModelDelegate(_ detailViewModel:DetailViewModel, didLoadPicture image: UIImage)
}

protocol DetailsViewModelProtocol {
    
    var delegate: DetailsViewModelDelegate? { get set }
    
    var beerName: String { get }
    var abvLevel: String { get }
    var description: String { get }
    var foodPairing: String { get }
    
    func loadPicture()
    
}
