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
            tableManager?.contentCells = content
            DispatchQueue.main.async {
                self.reloadData()
            }
            print(content.count)
        }
    }
    
    private var viewModel: IDealsTableViewModel
    private var tableManager: IDealsTableManager?
    
    // MARK: - Lifecycle
    
    init(viewModel: IDealsTableViewModel) {
        
        self.viewModel = viewModel
        
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
        tableManager = DealsTableManager(contentCells: content)
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
        tableHeaderView?.frame.size.height = 35

    }

}

