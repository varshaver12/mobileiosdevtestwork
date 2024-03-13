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
    private var currentSort: DealsSorting.SortOrder
    
    private var sortingLabel = UILabel(font: UIFont(name: "SFProDisplay-Bold", size: 14))
    private lazy var sortOrderButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .clear
        button.setTitle("", for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Bold", size: Constants.fontSize12)
        button.tintColor = .blue
        button.addTarget(self, action: #selector(sortOrderButtonTapped), for: .touchUpInside)
        return button
    }()
    
    
    // MARK: - Life Cycle
    
    init(viewModel: IBottomSheetViewModel, currentSort: DealsSorting.SortOrder) {
        self.viewModel = viewModel
        self.currentSort = currentSort

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
        sortOrderButton.titleLabel?.text = currentSort.orderName
        backgroundColor = .white
    }
    
    private func setupSubViews() {
        addSubview(sortingLabel)
        addSubview(sortOrderButton)
    }
    
    private func setupConstraint() {
        sortingLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(Constants.inset20)
            $0.width.equalTo(LocalConstants.screenWidth * LocalConstants.multiplierInstrumentName)
            $0.top.equalToSuperview()
        }
        
        sortOrderButton.snp.makeConstraints {
            $0.leading.equalTo(sortingLabel.snp.trailing)
            $0.width.equalTo(LocalConstants.screenWidth * LocalConstants.multiplierPrice)
            $0.top.equalToSuperview()
        }

    }
    
}

private extension BottomSheetHeader {
    @objc func sortOrderButtonTapped() {
        currentSort = currentSort == .ascending ? .descending : .ascending
        sortOrderButton.titleLabel?.text = currentSort.orderName
    }
}


private extension BottomSheetHeader {
    enum LocalConstants {
        static let screenWidth = UIScreen.main.bounds.width - 40
        static let multiplierInstrumentName: CGFloat = 2 / 5
        static let multiplierPrice: CGFloat = 1 / 5
        static let multiplierAmount: CGFloat = 1.5 / 5
        static let multiplierSide: CGFloat = 0.5 / 5
    }
}
