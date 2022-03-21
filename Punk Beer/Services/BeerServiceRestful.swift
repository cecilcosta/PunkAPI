//
//  BeerServiceRestful.swift
//  Punk Beer
//
//  Created by Cecil Costa on 19/03/2022.
//

import Foundation

class BeerServiceRestful: BeerService {
    
    private let baseUrl = "https://api.punkapi.com/v2/beers"
    private let decoder = JSONDecoder()
    private let queryItemAbvLtKey = "abv_lt"
    private let queryItemAbvGtKey = "abv_gt"
    private let queryItemPageKey = "page"
    
    func fetchBeers(_ configuration: BeerServiceConfiguration) async throws -> [BeerModel]? {
        
        guard let finalUrl = self.url(for: configuration) else {
            return nil
        }
        
        let urlRequest = URLRequest(url: finalUrl)
        
        
        let (data, _) = try await URLSession.shared.data(for: urlRequest)
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode([BeerModel].self , from: data)
    }
    
    func url(for configuration: BeerServiceConfiguration) -> URL? {
        guard let url = URL(string: baseUrl) else {
            return nil
        }
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        var queryItems = [URLQueryItem]()
        let pageItem = URLQueryItem(name: queryItemPageKey, value: "\(configuration.page)")
        queryItems.append(pageItem)
        
        switch configuration.abvType {
        case .low:
            let lowQueryItem = URLQueryItem(name: queryItemAbvLtKey, value: "\(BeerAbvConstants.lowAbvTopBound)")
            queryItems.append(lowQueryItem)
        case .medium:
            let lowQueryItem = URLQueryItem(name: queryItemAbvGtKey, value: "\(BeerAbvConstants.lowAbvTopBound)")
            let highQueryItem = URLQueryItem(name: queryItemAbvLtKey, value: "\(BeerAbvConstants.highAbvLowBound)")
            queryItems.append(lowQueryItem)
            queryItems.append(highQueryItem)
        case .high:
            let highQueryItem = URLQueryItem(name: queryItemAbvGtKey, value: "\(BeerAbvConstants.highAbvLowBound)")
            queryItems.append(highQueryItem)
        case .all:
            ()
        }
        
        components?.queryItems = queryItems
        return components?.url
    }
    
}
