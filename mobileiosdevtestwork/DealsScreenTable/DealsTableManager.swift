//
//  DealsTableManager.swift
//  mobileiosdevtestwork
//
//  Created by Aleksey Khlestkin on 13.03.2024.
//

import SnapKit

protocol IDealsTableManager: UITableViewDelegate, UITableViewDataSource {
    var contentCells: [Deal] { get set }
}

final class DealsTableManager: NSObject {
    
    // MARK: - Internal properties
    
    var contentCells: [Deal] {
        didSet {
            switch currentSort {
                
            case .dealModificationDate(let sortOrder):
                if sortOrder == .ascending {
                    contentCells.sort { $0.dateModifier < $1.dateModifier }
                } else {
                    contentCells.sort { $0.dateModifier > $1.dateModifier }
                }
                
            case .instrumentName(let sortOrder):
                if sortOrder == .ascending {
                    contentCells.sort { $0.instrumentName < $1.instrumentName }
                } else {
                    contentCells.sort { $0.instrumentName > $1.instrumentName }
                }
                
            case .dealPrice(let sortOrder):
                if sortOrder == .ascending {
                    contentCells.sort { $0.price < $1.price }
                } else {
                    contentCells.sort { $0.price > $1.price }
                }
                
            case .dealVolume(let sortOrder):
                if sortOrder == .ascending {
                    contentCells.sort { $0.amount < $1.amount }
                } else {
                    contentCells.sort { $0.amount > $1.amount }
                }
                
            case .dealSide(let sortOrder):
                if sortOrder == .ascending {
                    contentCells.sort { $0.side.rawValue < $1.side.rawValue }
                } else {
                    contentCells.sort { $0.side.rawValue > $1.side.rawValue }
                }
                
            }
        }
    }
    var currentSort: DealsSorting = .dealModificationDate(sortOrder: .ascending)
    
    // MARK: - Lifecycle
    
    init(contentCells: [Deal]) {
        self.contentCells = contentCells
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
