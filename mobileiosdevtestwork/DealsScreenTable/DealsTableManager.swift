//
//  DealsTableManager.swift
//  mobileiosdevtestwork
//
//  Created by Aleksey Khlestkin on 13.03.2024.
//

import UIKit

protocol IDealsTableManager: UITableViewDelegate, UITableViewDataSource {
    var currentSort: (DealsSorting, SortOrder) { get set }
}

final class DealsTableManager: NSObject {
    
    // MARK: - Internal properties
    private let semaphore = DispatchSemaphore(value: 1)
    private var viewModel: IDealsScreenViewModel
    private var localArrayDeals: [Deal] = []
    private var lockSort = false
    private var numberOfRows = 0
    
    // MARK: - Internal properties
    var currentSort: (DealsSorting, SortOrder) {
        didSet {
            guard lockSort == false else {
                return
            }
            sortingDeals()
        }
    }
    
    // MARK: - Lifecycle
    
    init(viewModel: IDealsScreenViewModel, currentSort: (DealsSorting, SortOrder)) {
        
        self.viewModel = viewModel
        self.currentSort = currentSort
        super.init()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(dataUpdated(_:)),
                                               name: Notification.Name("DataUpdated"),
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(sortUpdated(_:)),
                                               name: Notification.Name("SortUpdated"),
                                               object: nil)
    }
}


// MARK: - IDealsTableManager
extension DealsTableManager: IDealsTableManager {
    
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DealTableViewCell.cellIdentifier,
                                                       for: indexPath) as? DealTableViewCell else {
            return UITableViewCell()
        }
        semaphore.wait()
        cell.setContent(deal: localArrayDeals[indexPath.row])
        semaphore.signal()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return Constants.heightForRow
    }

}

// MARK: - Private Methods
private extension DealsTableManager {

    func sortingDeals() {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else { return }
            
            switch currentSort.0 {
                
            case .dealModificationDate:
                if currentSort.1 == .ascending {
                    localArrayDeals.sort { $0.dateModifier < $1.dateModifier }
                } else {
                    localArrayDeals.sort { $0.dateModifier > $1.dateModifier }
                }
                
            case .instrumentName:
                if currentSort.1 == .ascending {
                    localArrayDeals.sort { $0.instrumentName < $1.instrumentName }
                } else {
                    localArrayDeals.sort { $0.instrumentName > $1.instrumentName }
                }
                
            case .dealPrice:
                if currentSort.1 == .ascending {
                    localArrayDeals.sort { $0.price < $1.price }
                } else {
                    localArrayDeals.sort { $0.price > $1.price }
                }
                
            case .dealVolume:
                if currentSort.1 == .ascending {
                    localArrayDeals.sort { $0.amount < $1.amount }
                } else {
                    localArrayDeals.sort { $0.amount > $1.amount }
                }
                
            case .dealSide:
                if currentSort.1 == .ascending {
                    localArrayDeals.sort { $0.side.rawValue < $1.side.rawValue }
                } else {
                    localArrayDeals.sort { $0.side.rawValue > $1.side.rawValue }
                }
            }
        }
    }
}

// MARK: - Objective-C Methods
@objc
extension DealsTableManager {
    func dataUpdated(_ notification: Notification) {
        
        
        viewModel.concurrentQueue.async(flags: .barrier) { [weak self] in
            self?.semaphore.wait()
            guard let self = self else { return }
            guard !self.viewModel.content.isEmpty else { return }
            
            self.lockSort = true
            self.localArrayDeals += self.viewModel.content
            self.numberOfRows = self.localArrayDeals.count
            self.viewModel.content.removeAll()
            self.sortingDeals()
            self.lockSort = false
            
            NotificationCenter.default.post(name: Notification.Name("CopyEnded"), object: nil)
            semaphore.signal()
        }
        
        DispatchQueue.main.async {
            NotificationCenter.default.post(name: Notification.Name("ReloadContent"), object: nil)
        }
    }
    
    func sortUpdated(_ notification: Notification) {
        currentSort = viewModel.currentSort
    }
}
