//
//  BottomSheetManager.swift
//  mobileiosdevtestwork
//
//  Created by Aleksey Khlestkin on 13.03.2024.
//

import UIKit

protocol IBottomSheetManager: UITableViewDelegate, UITableViewDataSource {
    var viewModel: IBottomSheetViewModel { get set }
}

final class BottomSheetManager: NSObject {
    
    // MARK: - Internal properties
    
    private var allCasesDealsSorting = DealsSorting.allCases
    var viewModel: IBottomSheetViewModel
    
    // MARK: - Lifecycle
    
    init(viewModel: IBottomSheetViewModel) {
        self.viewModel = viewModel
    }
    
}

// MARK: - IBottomSheetManager

extension BottomSheetManager: IBottomSheetManager {
    
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        DealsSorting.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BottomSheetCell.cellIdentifier,
                                                       for: indexPath) as? BottomSheetCell else {
            return UITableViewCell()
        }
        
        cell.setContent(nameSort: allCasesDealsSorting[indexPath.row].sortName,
                        isSelected: allCasesDealsSorting[indexPath.row].sortName == viewModel.currentSort.0.sortName )
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return LocalConstants.heightCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.currentSort.0 = allCasesDealsSorting[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
        tableView.reloadData()
    }
    
}

private extension BottomSheetManager {
    enum LocalConstants {
        static let heightCell: CGFloat = 60
    }
}
