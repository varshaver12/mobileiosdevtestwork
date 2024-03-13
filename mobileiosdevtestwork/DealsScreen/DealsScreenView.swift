//
//  DealsScreenView.swift
//  mobileiosdevtestwork
//
//  Created by Aleksey Khlestkin on 13.03.2024.
//

import SnapKit

final class DealsScreenView: UIViewController {
    
    private var viewModel: IDealsScreenViewModel
    private var tableView: DealsScreenTableView?
    
    private lazy var server = Server()
//    private lazy var model: [Deal] = [] {
//        didSet {
//            tableView?.content = model
//            print(model.count)
//        }
//    }
    
    init(viewModel: IDealsScreenViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        tableView = createTable()
        view = tableView
        setupConfiguration()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
    }
    
}

private extension DealsScreenView {
    
    func setupConfiguration() {
        
        navigationItem.title = "Deals"
        
        server.subscribeToDeals { [weak self] deals in
            guard let self = self else { return }
            self.tableView?.content.append(contentsOf: deals)
        }
    }
    
    func createTable() -> DealsScreenTableView {
        let tableViewModel = DealsTableViewModel()
        return DealsScreenTableView(viewModel: tableViewModel)
    }
    
    func setupView() {
        
    }
    
    func setupConstraints() {
        
    }
}

