//
//  BottomSheetViewModel.swift
//  mobileiosdevtestwork
//
//  Created by Aleksey Khlestkin on 13.03.2024.
//

import Foundation

protocol IBottomSheetViewModel {
    var currentSort: (DealsSorting, SortOrder) { get set}
    
    func sortOrderButtonTapped()
}

final class BottomSheetViewModel: IBottomSheetViewModel {
    
    var currentSort: (DealsSorting, SortOrder) {
        didSet {
            print(currentSort.0.sortName)
            print(currentSort.1.orderName)
        }
    }
    
    private weak var delegate: DealsScreenView?
    
    init(delegate: DealsScreenView, currentSort: (DealsSorting, SortOrder)) {
        self.delegate = delegate
        self.currentSort = currentSort
    }
    
    func sortOrderButtonTapped() {
        print("func sortOrderButtonTapped()")
        delegate?.currentSort = currentSort
        delegate?.dismiss(animated: true)
    }
    
}
