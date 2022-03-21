//
//  ViewController.swift
//  Punk Beer
//
//  Created by Cecil Costa on 19/03/2022.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    
    var chosenIndex: Int?
    let service = BeerServiceFactory.service(for: .restful)
    var beerServiceViewModel: BeerServiceViewModelProtocol? {
        didSet {
            beerServiceViewModel?.delegate = self
            updateUI()
        }
    }
    private let cellIdentifier = "cell"
    private let beerDetailsSegueName = "beer_details"
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.beerServiceViewModel = BeerServiceViewModel(service: self.service)
        Task {
            try await self.beerServiceViewModel?.loadFirstPage()
            updateUI()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == beerDetailsSegueName, let detailsViewController = segue.destination as? DetailsViewController,
           let chosenIndex = self.chosenIndex {
            detailsViewController.detailViewModel = beerServiceViewModel?.detailViewModel(for: chosenIndex)
        }
    }
    
    // MARK: - Events
    
    @IBAction func segmentedControlChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            self.beerServiceViewModel?.filterType = .all
        case 1:
            self.beerServiceViewModel?.filterType = .low
        case 2:
            self.beerServiceViewModel?.filterType = .medium
        case 3:
            self.beerServiceViewModel?.filterType = .high
        default:
            fatalError("Unexpected case, please fix it! 🙏")
        }
    }
    
    
    // MARK: - Private
    
    private func updateUI() {
        tableView.reloadData()
    }


}


// MARK: DataSource

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.beerServiceViewModel?.numberOfItems ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? BeerTableViewCell else {
            fatalError("Cell Not registred 🤷🏽‍♂️")
        }
        
        if let beerServiceViewModel = self.beerServiceViewModel,
           let viewModel = beerServiceViewModel.viewModel(for: indexPath.row) {
            cell.configure(with: viewModel)
        }
        
        return cell
    }
    
    
}


// MARK: Delegate

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        chosenIndex = indexPath.row
        performSegue(withIdentifier: beerDetailsSegueName, sender: self)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(50)
    }
    
}


// MARK: - Prefetch datasource

extension ViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        // TODO: Do a real prefetch would be great!
        indexPaths.forEach {
            self.beerServiceViewModel?.loadNextCells(for: $0.row)
        }
        
        
    }
}


extension ViewController: BeerServiceViewModelDelegate {
    func beerServiceViewModel(_ beerServiceViewModel: BeerServiceViewModel, didLoadNextPage last: Bool) {
        DispatchQueue.main.async {
            self.updateUI()
        }
        
    }
}
