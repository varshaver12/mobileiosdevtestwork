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
    
    var currentSort: (DealsSorting, SortOrder)
    
    private weak var delegate: DealsScreenView?
    
    init(delegate: DealsScreenView, currentSort: (DealsSorting, SortOrder)) {
        self.delegate = delegate
        self.currentSort = currentSort
    }
    
    func sortOrderButtonTapped() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            self.delegate?.dismiss(animated: true, completion: {
                self.delegate?.viewModel.currentSort = self.currentSort
            })
        }
    }
    
}
