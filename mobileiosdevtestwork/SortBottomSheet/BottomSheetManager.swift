//
//  BottomSheetManager.swift
//  mobileiosdevtestwork
//
//  Created by Aleksey Khlestkin on 13.03.2024.
//

import UIKit

protocol IBottomSheetManager: UITableViewDelegate, UITableViewDataSource {
    var currentSort: DealsSorting { get set }
}

final class BottomSheetManager: NSObject {
    
    // MARK: - Internal properties
    
    var currentSort: DealsSorting
    let sortingOptions: [DealsSorting] = [.dealModificationDate(sortOrder: .ascending),
                                          .instrumentName(sortOrder: .ascending),
                                          .dealPrice(sortOrder: .ascending),
                                          .dealVolume(sortOrder: .ascending),
                                          .dealSide(sortOrder: .ascending)]
    
    // MARK: - Lifecycle
    
    init(currentSort: DealsSorting) {
        self.currentSort = currentSort
    }
    
}

// MARK: - IBottomSheetManager

extension BottomSheetManager: IBottomSheetManager {
    
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        sortingOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BottomSheetCell.cellIdentifier,
                                                       for: indexPath) as? BottomSheetCell else {
            return UITableViewCell()
        }
        
        let sortingOption = sortingOptions[indexPath.row]
        print(sortingOption.sortName)
        print(currentSort.sortName)
        cell.setContent(nameSort: sortingOption.sortName,
                        isSelected: sortingOption.sortName == currentSort.sortName )
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return Constants.heightForRow
    }
    
}

