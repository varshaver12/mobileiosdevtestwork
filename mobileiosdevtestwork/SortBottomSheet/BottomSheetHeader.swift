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
    
    private var sortingLabel = UILabel(text: LocalConstants.sortingLabel,
                                       font: UIFont(name: LocalConstants.textFont, size: LocalConstants.textSizeHigh),
                                       textAlignment: .left)
    private lazy var sortOrderButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .white
        button.setTitle(LocalConstants.empty, for: .normal)
        button.titleLabel?.font = UIFont(name: LocalConstants.textFont, size: LocalConstants.textSize)
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

private extension BottomSheetHeader {
    enum LocalConstants {
        static let textSize: CGFloat = 18
        static let textSizeHigh: CGFloat = 24
        
        static let textFont: String = "Apple SD Gothic Neo UltraLight"
        static let sortingLabel: String = "Сортировать"
        static let empty: String = ""
    }
}

