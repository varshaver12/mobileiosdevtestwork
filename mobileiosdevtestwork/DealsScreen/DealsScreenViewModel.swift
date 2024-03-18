//
//  DealsScreenViewModel.swift
//  mobileiosdevtestwork
//
//  Created by Aleksey Khlestkin on 13.03.2024.
//

import UIKit

protocol IDealsScreenViewModel {
    var content: [Deal] { get set}
    var currentSort: (DealsSorting, SortOrder) { get set }
    var concurrentQueue: DispatchQueue { get }
    
    func openSortingSettingsScreen(initialViewController: DealsScreenView)
    func getNewDeal()
}

final class DealsScreenViewModel: IDealsScreenViewModel {
    
    // MARK: - Private properties
    private lazy var server = Server()
    private var flagNotification = true
    // MARK: - Internal properties
    let concurrentQueue = DispatchQueue(label: "getNewDeal", attributes: .concurrent)
    var content: [Deal] = []
    
    var currentSort: (DealsSorting, SortOrder) = (.dealModificationDate, .descending) {
        didSet {
            DispatchQueue.main.async {
                NotificationCenter.default.post(name: Notification.Name("SortUpdated"), object: nil)
            }
        }
    }
    
    init() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(copyEnded(_:)),
                                               name: Notification.Name("CopyEnded"),
                                               object: nil)
    }
    
}

// MARK: - IDealsScreenViewModel Methods
extension DealsScreenViewModel {
    
    func getNewDeal() {
        server.subscribeToDeals { [weak self] deals in
            guard let self = self else { return }
            
            self.concurrentQueue.async {
                guard !deals.isEmpty else { return }
                self.content.append(contentsOf: deals)
                if self.flagNotification {
                    self.flagNotification = false
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        NotificationCenter.default.post(name: Notification.Name("DataUpdated"), object: nil)
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

// MARK: - Objective-C Methods
@objc
extension DealsScreenViewModel {
    func copyEnded(_ notification: Notification) {
        DispatchQueue.main.async {
            self.flagNotification = true
        }
    }
}

private extension DealsScreenViewModel {
    enum LocalConstants {
        static let sheetCornerRadius: CGFloat = 20
    }
}

