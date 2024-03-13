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
    private var currentSort: DealsSorting
    
    // MARK: - Lifecycle
    
    init(viewModel: IBottomSheetViewModel, currentSort: DealsSorting) {
        
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
        tableManager = BottomSheetManager(currentSort: currentSort)
        tableView.delegate = tableManager
        tableView.dataSource = tableManager
        
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.bounces = false
        tableView.allowsSelection = false
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        
        registerCell()
    }
    
    func registerCell() {
        tableView.register(BottomSheetCell.self, forCellReuseIdentifier: BottomSheetCell.cellIdentifier)
    }
    
    func setupConfigurates() {
        
        switch currentSort {
        case .dealModificationDate(let sortOrder):
            tableView.tableHeaderView = BottomSheetHeader(viewModel: viewModel, currentSort: sortOrder)
        case .instrumentName(let sortOrder):
            tableView.tableHeaderView = BottomSheetHeader(viewModel: viewModel, currentSort: sortOrder)
        case .dealPrice(let sortOrder):
            tableView.tableHeaderView = BottomSheetHeader(viewModel: viewModel, currentSort: sortOrder)
        case .dealVolume(let sortOrder):
            tableView.tableHeaderView = BottomSheetHeader(viewModel: viewModel, currentSort: sortOrder)
        case .dealSide(let sortOrder):
            tableView.tableHeaderView = BottomSheetHeader(viewModel: viewModel, currentSort: sortOrder)
        }
        
        tableView.tableHeaderView?.frame.size.height = 35
        
    }
    
}
