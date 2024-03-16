//
//  DealsScreenView.swift
//  mobileiosdevtestwork
//
//  Created by Aleksey Khlestkin on 13.03.2024.
//

import SnapKit
import Dispatch

final class DealsScreenView: UIViewController {
    
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
    
    var viewModel: IDealsScreenViewModel
    
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
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(sortUpdated(_:)),
                                               name: Notification.Name("SortUpdated"),
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(reloadContent(_:)),
                                               name: Notification.Name("ReloadContent"),
                                               object: nil)
        viewModel.getNewDeal()
    }
    
}

private extension DealsScreenView {
    
    @objc func sortUpdated(_ notification: Notification) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            
            let newTitle = self.viewModel.currentSort.0.sortName
            let indexPath = IndexPath(row: 0, section: 0)
            self.tableView?.scrollToRow(at: indexPath, at: .top, animated: true)
            self.sortButton.setTitle(newTitle, for: .normal)
            tableView?.reloadData()
        }
    }
    
    @objc func reloadContent(_ notification: Notification) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            tableView?.reloadData()
        }
    }
    
    @objc func apllyButtonTapped() {
        viewModel.openSortingSettingsScreen(initialViewController: self)
    }
    
    func setupConfiguration() {
        
        navigationItem.title = LocalConstants.navTitle
        
    }
    
    func createTable() -> DealsScreenTableView {
        return DealsScreenTableView(viewModel: viewModel)
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
