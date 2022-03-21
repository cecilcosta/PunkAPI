//
//  DetailViewModel.swift
//  Punk Beer
//
//  Created by Cecil Costa on 19/03/2022.
//

import Foundation
import UIKit


struct DetailViewModel: DetailsViewModelProtocol {
    private let beerModel: BeerModel
    
    weak var delegate: DetailsViewModelDelegate?
    
    var beerName: String {
        return beerModel.name
    }
    
    var abvLevel: String {
        return "Abv: \(beerModel.abv)%"
    }
    
    var description: String {
        return beerModel.description
    }
    
    var foodPairing: String {
        return beerModel.foodPairing.map { "‣ \($0)"}.joined(separator: "\n")
    }
    
    init(beerModel: BeerModel) {
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
                self.delegate?.detailsViewModelDelegate(self, didLoadPicture: image)
            }
        }

    }
}
