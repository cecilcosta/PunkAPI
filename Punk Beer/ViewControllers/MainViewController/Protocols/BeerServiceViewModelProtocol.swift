//
//  BeerServiceViewModelProtocol.swift
//  Punk Beer
//
//  Created by Cecil Costa on 20/03/2022.
//

import Foundation

protocol BeerServiceViewModelProtocol {
    
    var delegate: BeerServiceViewModelDelegate? { get set }
    var filterType: AbvType { get set }
    var numberOfItems: Int { get }
    
    func loadFirstPage() async throws
    func nextPage() async throws
    func detailViewModel(for index: Int) -> DetailsViewModelProtocol
    func viewModel(for index: Int) -> BeerViewModel?
    func loadNextCells(for index: Int)
    
}
