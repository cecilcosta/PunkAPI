//
//  BeerViewModel.swift
//  Punk Beer
//
//  Created by Cecil Costa on 19/03/2022.
//

import Foundation
import UIKit

protocol BeerViewModelDelegate: AnyObject {
    func beerViewModel(_ beerViewModel: BeerViewModel, didLoadPicture image: UIImage)
}

struct BeerViewModel: BeerViewModelProtocol {
    
    private let beerModel: BeerModel
    
    var delegate: BeerViewModelDelegate?
    
    var beerName: String {
        return beerModel.name
    }
    
    var abvAbreviation: String {
        if beerModel.abv < BeerAbvConstants.lowAbvTopBound {
            return AbvType.low.rawValue
        }
        if beerModel.abv < BeerAbvConstants.highAbvLowBound {
            return AbvType.medium.rawValue
        }
        return AbvType.high.rawValue
    }
    var abvColour: UIColor {
        switch self.abvAbreviation {
        case  AbvType.low.rawValue:
            return BeerAbvColours.lowColour
        case  AbvType.medium.rawValue:
            return BeerAbvColours.mediumColour
        default:
            return BeerAbvColours.highColour
        }
    }
    
    init(beerModel: BeerModel){
        self.beerModel = beerModel
    }
    
    func loadPicture() {
        guard let url = URL(string: beerModel.imageUrl) else {
            return
        }
        Task {
            // Yes, I did want to create a service and a cache system for the pictures, but unfortunatelly I ran out of time.
            let (data, _) = try await URLSession.shared.data(from: url)
            if let image = UIImage(data: data) {
                self.delegate?.beerViewModel(self, didLoadPicture: image)
            }
            
        }

    }
    
}
