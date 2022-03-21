//
//  BeerTableViewCell.swift
//  Punk Beer
//
//  Created by Cecil Costa on 19/03/2022.
//

import UIKit

class BeerTableViewCell: UITableViewCell {

    @IBOutlet weak var abvLabel: UILabel!
    @IBOutlet weak var beerImage: UIImageView!
    @IBOutlet weak var beerNameLabel: UILabel!
    
    var beerViewModel: BeerViewModelProtocol? {
        didSet {
            guard let beerViewModel = self.beerViewModel else {
                return
            }
            beerNameLabel.text = beerViewModel.beerName
            abvLabel.text = beerViewModel.abvAbreviation
            abvLabel.backgroundColor = beerViewModel.abvColour
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        abvLabel.layer.cornerRadius = abvLabel.frame.width / 2
        abvLabel.clipsToBounds = true
    }
    
    func configure(with viewModel: BeerViewModelProtocol){
        beerViewModel = viewModel
        beerViewModel?.delegate = self
        beerViewModel?.loadPicture()
        
    }

}

extension BeerTableViewCell: BeerViewModelDelegate {
    func beerViewModel(_ beerViewModel: BeerViewModel, didLoadPicture image: UIImage) {
        DispatchQueue.main.async {
            self.beerImage.image = image
        }
    }
}
