//
//  BeerServiceManager.swift
//  Punk Beer
//
//  Created by Cecil Costa on 19/03/2022.
//

import Foundation

protocol BeerServiceViewModelDelegate : AnyObject {
    func beerServiceViewModel(_ beerServiceViewModel: BeerServiceViewModel, didLoadNextPage last: Bool)
}


class BeerServiceViewModel: BeerServiceViewModelProtocol  {
    
    
    
    private var nextPage = 1
    private var done = false
    private let service: BeerService
    private var beers: [BeerModel] = []
    

    weak var delegate: BeerServiceViewModelDelegate?
    var filterType = AbvType.all {
        didSet {
            Task {
                try await self.loadFirstPage()
            }
        }
    }
    
    var numberOfItems: Int {
        return beers.count
    }
    
    init(service: BeerService) {
        self.service = service
    }
    
    
    
    func loadFirstPage() async throws {
        nextPage = 1
        done = false
        self.beers.removeAll()
        try await self.nextPage()
    }
    
    func nextPage() async throws {
        guard let beers = try await self.fetchBeers() else {
            return
        }
        if  beers.count == 0 {
            self.done = true
        } else {
            self.beers.append(contentsOf: beers)
        }
        self.delegate?.beerServiceViewModel(self, didLoadNextPage: self.done)
    }
    
    func viewModel(for index: Int) -> BeerViewModel? {
        guard index < beers.count else {
            return nil
        }
        return BeerViewModel(beerModel: beers[index])
    }
    
    func detailViewModel(for index: Int) -> DetailsViewModelProtocol {
        return DetailViewModel(beerModel: beers[index])
    }
    
    func loadNextCells(for index: Int) {
        if !done, index == self.beers.count - 1 {
            Task {
                try await self.nextPage()
            }
        }
    }
    
    private func fetchBeers() async throws -> [BeerModel]? {
        
        let configuration = BeerServiceConfiguration(page: nextPage, abvType: self.filterType)
        let beers = try await service.fetchBeers(configuration)
        nextPage += 1
        
        return beers
    }
    
    
    
}
