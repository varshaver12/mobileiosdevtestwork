//
//  BottomSheetTableView.swift
//  mobileiosdevtestwork
//
//  Created by Aleksey Khlestkin on 13.03.2024.
//

import UIKit

final class BottomSheetTableView: UITableViewController {
    
    private var viewModel: IBottomSheetViewModel
    private var tableManager: IBottomSheetManager?
    private var currentSort: (DealsSorting, SortOrder)
    
    // MARK: - Lifecycle
    
    init(viewModel: IBottomSheetViewModel, currentSort: (DealsSorting, SortOrder)) {
        
        self.viewModel = viewModel
        self.currentSort = currentSort
        
        super.init(style: .plain)
        
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
        tableManager = BottomSheetManager(viewModel: viewModel)
        tableView.delegate = tableManager
        tableView.dataSource = tableManager
        
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.bounces = false
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        
        registerCell()
    }
    
    func registerCell() {
        tableView.register(BottomSheetCell.self, forCellReuseIdentifier: BottomSheetCell.cellIdentifier)
    }
    
    func setupConfigurates() {
        
        tableView.tableHeaderView = BottomSheetHeader(viewModel: viewModel, currentSortOrder: currentSort.1)
        tableView.tableFooterView = BottomSheetFooter(viewModel: viewModel)
        tableView.tableHeaderView?.frame.size.height = LocalConstants.headerHeight
        tableView.tableFooterView?.frame.size.height = LocalConstants.footerHeight
    }
    
}

private extension BottomSheetTableView {
    enum LocalConstants {
        static let headerHeight: CGFloat = 80
        static let footerHeight: CGFloat = 60

    }
}
