//
//  BottomSheetHeader.swift
//  mobileiosdevtestwork
//
//  Created by Aleksey Khlestkin on 13.03.2024.
//

import SnapKit

final class BottomSheetHeader: UIView {
    
    // MARK: - Private properties
    
    private var viewModel: IBottomSheetViewModel
    private var currentSortOrder: SortOrder
    
    private var sortingLabel = UILabel(text: "Сортировать",
                                       font: UIFont(name: "Apple SD Gothic Neo UltraLight", size: 24),
                                       textAlignment: .left)
    private lazy var sortOrderButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .white
        button.setTitle("", for: .normal)
        button.titleLabel?.font = UIFont(name: "Apple SD Gothic Neo UltraLight", size: 18)
        button.tintColor = .blue
        button.titleLabel?.textAlignment = .right
        button.addTarget(self, action: #selector(sortOrderButtonTapped), for: .touchUpInside)
        return button
    }()
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 4
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    
    
    
    // MARK: - Life Cycle
    
    init(viewModel: IBottomSheetViewModel, currentSortOrder: SortOrder) {
        self.viewModel = viewModel
        self.currentSortOrder = currentSortOrder
        
        super.init(frame: .zero)
        
        setupConfiguration()
        setupSubViews()
        setupConstraint()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - Private methods

extension BottomSheetHeader {
    
    func setupConfiguration() {
        sortOrderButton.setTitle(currentSortOrder.orderName, for: .normal)
        backgroundColor = .white
    }
    
    private func setupSubViews() {
        stackView.addArrangedSubview(sortingLabel)
        stackView.addArrangedSubview(sortOrderButton)
        
        addSubview(stackView)
    }
    
    private func setupConstraint() {
        stackView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(Constants.inset20)
            $0.trailing.equalToSuperview().inset(Constants.inset20)
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
}

private extension BottomSheetHeader {
    @objc func sortOrderButtonTapped() {
        currentSortOrder = currentSortOrder == .ascending ? .descending : .ascending
        sortOrderButton.setTitle(currentSortOrder.orderName, for: .normal)
        viewModel.currentSort.1 = currentSortOrder
    }
}

