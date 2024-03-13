//
//  BottomSheetView.swift
//  mobileiosdevtestwork
//
//  Created by Aleksey Khlestkin on 13.03.2024.
//

import UIKit

final class BottomSheetTableView: UITableView {
    
    private var viewModel: IBottomSheetViewModel
    private var tableManager: IBottomSheetManager?
    private var currentSort: DealsSorting
    
    // MARK: - Lifecycle
    
    init(viewModel: IBottomSheetViewModel, currentSort: DealsSorting) {
        
        self.viewModel = viewModel
        self.currentSort = currentSort
        
        super.init(frame: .zero, style: .plain)
        
        tableSetup()
        setupConfigurates()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension BottomSheetTableView {
    
    func tableSetup() {
        tableManager = BottomSheetManager(currentSort: currentSort)
        delegate = tableManager
        dataSource = tableManager
        
        backgroundColor = .white
        separatorStyle = .none
        bounces = false
        allowsSelection = false
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
        
        registerCell()
    }
    
    func registerCell() {
        register(BottomSheetCell.self, forCellReuseIdentifier: BottomSheetCell.cellIdentifier)
    }
    
    func setupConfigurates() {
        
    }

}
