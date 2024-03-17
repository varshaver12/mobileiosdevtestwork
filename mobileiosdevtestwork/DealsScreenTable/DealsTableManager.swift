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
    let lockLocalContent = NSLock()
    private var viewModel: IDealsScreenViewModel
    
    private var localContentTable: [Deal] = []
    
    var currentSort: (DealsSorting, SortOrder) {
        didSet {
            sotingDeals()
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
    
    @objc func dataUpdated(_ notification: Notification) {
        lockLocalContent.lock()
        if !viewModel.content.isEmpty {
            localContentTable += viewModel.content
            viewModel.content.removeAll()
            
        }
        lockLocalContent.unlock()
        
        sotingDeals()
        DispatchQueue.main.async {
            NotificationCenter.default.post(name: Notification.Name("ReloadContent"), object: nil)
        }
    }
    
    @objc func sortUpdated(_ notification: Notification) {
        currentSort = viewModel.currentSort
    }
    
}

// MARK: - IDealsTableManager

extension DealsTableManager: IDealsTableManager {
    
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        localContentTable.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DealTableViewCell.cellIdentifier,
                                                       for: indexPath) as? DealTableViewCell else {
            return UITableViewCell()
        }
        cell.setContent(deal: localContentTable[indexPath.row])
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return Constants.heightForRow
    }
    
    func sotingDeals() {
        DispatchQueue(label: "sortLocalContentTable").async { [weak self] in
            guard let self = self else { return }
            
            lockLocalContent.lock()
            switch currentSort.0 {
                
            case .dealModificationDate:
                if currentSort.1 == .ascending {
                    localContentTable.sort { $0.dateModifier < $1.dateModifier }
                } else {
                    localContentTable.sort { $0.dateModifier > $1.dateModifier }
                }
                
            case .instrumentName:
                if currentSort.1 == .ascending {
                    localContentTable.sort { $0.instrumentName < $1.instrumentName }
                } else {
                    localContentTable.sort { $0.instrumentName > $1.instrumentName }
                }
                
            case .dealPrice:
                if currentSort.1 == .ascending {
                    localContentTable.sort { $0.price < $1.price }
                } else {
                    localContentTable.sort { $0.price > $1.price }
                }
                
            case .dealVolume:
                if currentSort.1 == .ascending {
                    localContentTable.sort { $0.amount < $1.amount }
                } else {
                    localContentTable.sort { $0.amount > $1.amount }
                }
                
            case .dealSide:
                if currentSort.1 == .ascending {
                    localContentTable.sort { $0.side.rawValue < $1.side.rawValue }
                } else {
                    localContentTable.sort { $0.side.rawValue > $1.side.rawValue }
                }
            }
            lockLocalContent.unlock()
        }

    }
}
