//
//  BottomSheetFooter.swift
//  mobileiosdevtestwork
//
//  Created by Aleksey Khlestkin on 13.03.2024.
//

import SnapKit

final class BottomSheetFooter: UIView {
    
    // MARK: - Properties
    
    private var viewModel: IBottomSheetViewModel
    private lazy var button = createButton()
    
    // MARK: - Life Cycle
    
    init(viewModel: IBottomSheetViewModel) {
        self.viewModel = viewModel
        
        super.init(frame: .zero)
        setupSubViews()
        setupConfiguration()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - Private methods

private extension BottomSheetFooter {
    
    func setupSubViews() {
        addSubview(button)
        
        button.snp.makeConstraints {
            $0.height.equalTo(Constants.offset40)
            $0.leading.trailing.equalToSuperview().inset(Constants.offset20)
            $0.top.greaterThanOrEqualToSuperview()
            $0.bottom.equalToSuperview().inset(Constants.offset8)
        }
    }
    
    func createButton() -> UIButton {
        let button = UIButton(type: .system)
        button.backgroundColor = .blue
        button.layer.cornerRadius = LocalConstants.bottonCornerRadius
        button.setTitle(LocalConstants.bottomButtonText, for: .normal)
        button.titleLabel?.font = UIFont(name: LocalConstants.textFont, size: LocalConstants.textSize)
        button.tintColor = .white
        return button
    }
    
    func setupConfiguration() {
        backgroundColor = .white
        button.addTarget(self, action: #selector(handlePressedButton), for: .touchUpInside)
    }
    
    @objc
    func handlePressedButton() {
        viewModel.sortOrderButtonTapped()
    }
    
}

// MARK: - LocalConstants

private extension BottomSheetFooter {
    
    enum LocalConstants {
        static let textSize: CGFloat = 20
        static let bottonCornerRadius: CGFloat = 8
        
        static let bottomButtonText = "Применить"
        static let textFont: String = "Apple SD Gothic Neo UltraLight"
    }
    
}

