//
//  DetailsViewController.swift
//  Punk Beer
//
//  Created by Cecil Costa on 19/03/2022.
//

import UIKit

class DetailsViewController: UIViewController {
    
    var detailViewModel: DetailsViewModelProtocol! {
        didSet {
            self.detailViewModel.delegate = self
        }
    }
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var beerPicture: UIImageView!
    @IBOutlet weak var abvLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var foodPairingLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.nameLabel.text = detailViewModel.beerName
        self.abvLabel.text = detailViewModel.abvLevel
        self.descriptionLabel.text = detailViewModel.description
        self.foodPairingLabel.text = detailViewModel.foodPairing
        self.detailViewModel.loadPicture()
    }
    
    
}

extension DetailsViewController: DetailsViewModelDelegate {
    func detailsViewModelDelegate(_ detailViewModel: DetailViewModel, didLoadPicture image: UIImage) {
        DispatchQueue.main.async {
            self.beerPicture.image = image
        }
    }
}
