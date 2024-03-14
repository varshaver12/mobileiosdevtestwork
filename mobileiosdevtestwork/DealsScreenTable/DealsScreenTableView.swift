//
//  DealsScreenTableView.swift
//  mobileiosdevtestwork
//
//  Created by Aleksey Khlestkin on 13.03.2024.
//

import UIKit

final class DealsScreenTableView: UITableView {
    
    var content: [Deal] = [] {
        didSet {
            tableManager?.newContentCells = content
            content = []
            DispatchQueue.main.async{ [weak self] in
                self?.reloadData()
            }
            
        }
    }
    
    var currentSort: (DealsSorting, SortOrder) {
        didSet {
            tableManager?.currentSort = currentSort
            DispatchQueue.main.async{ [weak self] in
                self?.reloadData()
                let indexPath = IndexPath(row: 0, section: 0)
                self?.scrollToRow(at: indexPath, at: .top, animated: true)
            }
        }
    }
    
    private var viewModel: IDealsTableViewModel
    private var tableManager: IDealsTableManager?
    
    // MARK: - Lifecycle
    
    init(viewModel: IDealsTableViewModel, currentSort: (DealsSorting, SortOrder)) {
        
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

private extension DealsScreenTableView {
    
    func tableSetup() {
        tableManager = DealsTableManager(newContentCells: content, currentSort: currentSort)
        delegate = tableManager
        dataSource = tableManager
        
        separatorStyle = .none
        bounces = false
        allowsSelection = false
        showsVerticalScrollIndicator = true
        showsHorizontalScrollIndicator = false
        
        register(DealTableViewCell.self, forCellReuseIdentifier: DealTableViewCell.cellIdentifier)
    }
    
    func setupConfigurates() {
        
        tableHeaderView = DealsTableHeaderView()
        tableHeaderView?.frame.size.height = LocalConstants.tableHeaderHeight
        
    }
    
}

private extension DealsScreenTableView {
    enum LocalConstants {
        static let tableHeaderHeight: CGFloat = 35

    }
}
