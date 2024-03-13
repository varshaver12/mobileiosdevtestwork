//
//  BottomSheetViewModel.swift
//  mobileiosdevtestwork
//
//  Created by Aleksey Khlestkin on 13.03.2024.
//

import Foundation

protocol IBottomSheetViewModel {
    
}

final class BottomSheetViewModel: IBottomSheetViewModel {
    
    private weak var delegate: DealsScreenView?
    
    init(delegate: DealsScreenView) {
        self.delegate = delegate
    }
    
    func sortOrderButtonTapped(sortOrder: DealsSorting.SortOrder) {
        
    }
    
}
