//
//  DealsScreenView.swift
//  mobileiosdevtestwork
//
//  Created by Aleksey Khlestkin on 13.03.2024.
//

import SnapKit
import Dispatch

final class DealsScreenView: UIViewController {
    
    var currentSort: (DealsSorting, SortOrder) = (.dealModificationDate, .ascending) {
        didSet {
            tableView?.currentSort = currentSort
            sortButton.setTitle(currentSort.0.sortName, for: .normal)
        }
    }
    
    private var viewModel: IDealsScreenViewModel
    private var tableView: DealsScreenTableView?
    
    private lazy var sortButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .blue
        button.layer.cornerRadius = LocalConstants.buttonCornerRadius
        button.setTitle(LocalConstants.buttonContent, for: .normal)
        button.titleLabel?.font = UIFont(name: LocalConstants.textFont, size: LocalConstants.textSize)
        button.tintColor = .white
        button.addTarget(self, action: #selector(apllyButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var server = Server()
    
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
    
    @objc func apllyButtonTapped() {
        viewModel.openSortingSettingsScreen(initialViewController: self,
                                            currentSort: currentSort)
    }
    
    func setupConfiguration() {
        
        navigationItem.title = LocalConstants.navTitle

        server.subscribeToDeals { [weak self] deals in
            let group = DispatchGroup()
            group.enter()
            let queue = DispatchQueue.global(qos: .userInitiated)
            queue.async {
                guard let self = self else { return }
                self.tableView?.content.append(contentsOf: deals)
                group.leave()
            }
        }
    }
    
    func createTable() -> DealsScreenTableView {
        let tableViewModel = DealsTableViewModel()
        return DealsScreenTableView(viewModel: tableViewModel, currentSort: currentSort)
    }
    
    func setupView() {
        view.addSubview(sortButton)
    }
    
    func setupConstraints() {
        sortButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(Constants.inset20)
            $0.leading.greaterThanOrEqualToSuperview().inset(Constants.inset16)
            $0.trailing.greaterThanOrEqualToSuperview().inset(Constants.inset16)
            $0.width.equalTo(sortButton.titleLabel?.snp.width ?? LocalConstants.sortDefaultWidth).offset(Constants.offset40)
        }
    }
}

private extension DealsScreenView {
    enum LocalConstants {
        static let textSize: CGFloat = 18
        static let buttonCornerRadius: CGFloat = 10
        static let sortDefaultWidth: CGFloat = 60
        static let textFont: String = "Apple SD Gothic Neo UltraLight"
        static let buttonContent: String = "Дата изменения сделки"
        static let navTitle: String = "Deals"
    }
}
