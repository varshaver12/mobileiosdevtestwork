//
//  DealsScreenViewModel.swift
//  mobileiosdevtestwork
//
//  Created by Aleksey Khlestkin on 13.03.2024.
//

import UIKit

protocol IDealsScreenViewModel {
    func openSortingSettingsScreen(initialViewController: DealsScreenView)
    func getNewDeal()
    var content: [Deal] { get set}
    var currentSort: (DealsSorting, SortOrder) { get set }
}

final class DealsScreenViewModel: IDealsScreenViewModel {
    
    private lazy var server = Server()
    private var flagNotification = true
    let lockAppend = NSLock()
    var content: [Deal] = []
    
    var currentSort: (DealsSorting, SortOrder) = (.dealModificationDate, .descending) {
        didSet {
            DispatchQueue.main.async {
                NotificationCenter.default.post(name: Notification.Name("SortUpdated"), object: nil)
            }
        }
    }
    
    func getNewDeal() {
        server.subscribeToDeals { [weak self] deals in
            DispatchQueue(label: "getNewDeal").async {
                guard let self = self else { return }
                self.lockAppend.lock()
                self.content.append(contentsOf: deals)
                self.lockAppend.unlock()
                if self.flagNotification {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        NotificationCenter.default.post(name: Notification.Name("DataUpdated"), object: nil)
                        self.flagNotification = true
                    }
                    DispatchQueue.main.async {
                        self.flagNotification = false
                    }
                    
                }
                
            }
        }
    }
    
    func openSortingSettingsScreen(initialViewController: DealsScreenView) {
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

