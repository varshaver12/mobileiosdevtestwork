//
//  DealsTableManager.swift
//  mobileiosdevtestwork
//
//  Created by Aleksey Khlestkin on 13.03.2024.
//

import UIKit

protocol IDealsTableManager: UITableViewDelegate, UITableViewDataSource {
    var newContentCells: [Deal] { get set }
    var currentSort: (DealsSorting, SortOrder) { get set }
}

final class DealsTableManager: NSObject {
    
    // MARK: - Internal properties
    
    var currentSort: (DealsSorting, SortOrder)
    
    var newContentCells: [Deal] {
        didSet {
            contentCells.append(contentsOf: newContentCells)
            newContentCells = []
        }
    }
    
    var contentCells: [Deal] = [] {
        didSet {
            switch currentSort.0 {
                
            case .dealModificationDate:
                if currentSort.1 == .ascending {
                    contentCells.sort { $0.dateModifier < $1.dateModifier }
                } else {
                    contentCells.sort { $0.dateModifier > $1.dateModifier }
                }
                
            case .instrumentName:
                if currentSort.1 == .ascending {
                    contentCells.sort { $0.instrumentName < $1.instrumentName }
                } else {
                    contentCells.sort { $0.instrumentName > $1.instrumentName }
                }
                
            case .dealPrice:
                if currentSort.1 == .ascending {
                    contentCells.sort { $0.price < $1.price }
                } else {
                    contentCells.sort { $0.price > $1.price }
                }
                
            case .dealVolume:
                if currentSort.1 == .ascending {
                    contentCells.sort { $0.amount < $1.amount }
                } else {
                    contentCells.sort { $0.amount > $1.amount }
                }
                
            case .dealSide:
                if currentSort.1 == .ascending {
                    contentCells.sort { $0.side.rawValue < $1.side.rawValue }
                } else {
                    contentCells.sort { $0.side.rawValue > $1.side.rawValue }
                }
            }
            
        }
    }
    
    // MARK: - Lifecycle
    
    init(newContentCells: [Deal], currentSort: (DealsSorting, SortOrder)) {
        self.newContentCells = contentCells
        self.currentSort = currentSort
    }
    
}

// MARK: - IDealsTableManager

extension DealsTableManager: IDealsTableManager {
    
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        contentCells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DealTableViewCell.cellIdentifier,
                                                       for: indexPath) as? DealTableViewCell else {
            return UITableViewCell()
        }
        
        cell.setContent(deal: contentCells[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        return Constants.heightForRow
    }
}
