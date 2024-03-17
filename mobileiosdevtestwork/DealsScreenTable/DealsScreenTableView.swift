//
//  DealsScreenTableView.swift
//  mobileiosdevtestwork
//
//  Created by Aleksey Khlestkin on 13.03.2024.
//

import UIKit

final class DealsScreenTableView: UITableView {
    
    private var viewModel: IDealsScreenViewModel
    private var tableManager: IDealsTableManager?
    
    // MARK: - Lifecycle
    
    init(viewModel: IDealsScreenViewModel) {
        
        self.viewModel = viewModel
        
        super.init(frame: .zero, style: .plain)
        
        tableSetup()
        setupConfigurates()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(reloadContent(_:)),
                                               name: Notification.Name("ReloadContent"),
                                               object: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension DealsScreenTableView {
    
    @objc func reloadContent(_ notification: Notification) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }

            reloadData()
        }
    }
    
    func tableSetup() {
        tableManager = DealsTableManager(viewModel: viewModel, currentSort: viewModel.currentSort)
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
