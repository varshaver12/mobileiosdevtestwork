//
//  DealsScreenViewModel.swift
//  mobileiosdevtestwork
//
//  Created by Aleksey Khlestkin on 13.03.2024.
//

import UIKit

protocol IDealsScreenViewModel {
    func openSortingSettingsScreen(initialViewController: DealsScreenView, currentSort: (DealsSorting, SortOrder))
}

final class DealsScreenViewModel: IDealsScreenViewModel {
    
    func openSortingSettingsScreen(initialViewController: DealsScreenView, currentSort: (DealsSorting, SortOrder)) {
        let bottomSheetViewModel = BottomSheetViewModel(delegate: initialViewController, currentSort: currentSort)
        let bottomSheet = BottomSheetTableView(viewModel: bottomSheetViewModel, currentSort: currentSort)
        if let sheet = bottomSheet.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = LocalConstants.sheetCornerRadius
        }
        initialViewController.present(bottomSheet, animated: true)
    }
    
}

private extension DealsScreenViewModel {
    enum LocalConstants {
        static let sheetCornerRadius: CGFloat = 20
    }
}
