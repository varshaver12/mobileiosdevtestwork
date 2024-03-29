//
//  DealsTableHeaderView.swift
//  mobileiosdevtestwork
//
//  Created by Aleksey Khlestkin on 13.03.2024.
//

import SnapKit

final class DealsTableHeaderView: UIView {
    
    // MARK: - Private properties
    
    private var instrument = UILabel(font: UIFont(name: LocalConstants.textFont,
                                                  size: LocalConstants.textSize), textAlignment: .center)
    private var price = UILabel(font: UIFont(name: LocalConstants.textFont, size: LocalConstants.textSize))
    private var amount = UILabel(font: UIFont(name: LocalConstants.textFont, size: LocalConstants.textSize))
    private var side = UILabel(font: UIFont(name: LocalConstants.textFont, size: LocalConstants.textSize))
    
    // MARK: - Life Cycle
    
    init() {
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

extension DealsTableHeaderView {
    
    func setupConfiguration() {
        instrument.text = LocalConstants.instrument
        price.text = LocalConstants.price
        amount.text = LocalConstants.amount
        side.text = LocalConstants.side
        
        backgroundColor = UIColor.white
    }
    
    private func setupSubViews() {
        addSubview(instrument)
        addSubview(price)
        addSubview(amount)
        addSubview(side)
    }
    
    private func setupConstraint() {
        instrument.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(Constants.inset20)
            $0.width.equalTo(LocalConstants.screenWidth * LocalConstants.multiplierInstrumentName)
            $0.top.equalToSuperview()
        }
        
        price.snp.makeConstraints {
            $0.leading.equalTo(instrument.snp.trailing)
            $0.width.equalTo(LocalConstants.screenWidth * LocalConstants.multiplierPrice)
            $0.top.equalToSuperview()
        }
        
        amount.snp.makeConstraints {
            $0.leading.equalTo(price.snp.trailing)
            $0.width.equalTo(LocalConstants.screenWidth * LocalConstants.multiplierAmount)
            $0.top.equalToSuperview()
        }
        
        side.snp.makeConstraints {
            $0.leading.equalTo(amount.snp.trailing)
            $0.width.equalTo(LocalConstants.screenWidth * LocalConstants.multiplierSide)
            $0.top.equalToSuperview()
            $0.trailing.equalToSuperview().inset(Constants.inset20)
        }
        
    }
    
}


private extension DealsTableHeaderView {
    enum LocalConstants {
        static let screenWidth = UIScreen.main.bounds.width - 40
        static let multiplierInstrumentName: CGFloat = 2 / 5
        static let multiplierPrice: CGFloat = 1 / 5
        static let multiplierAmount: CGFloat = 1.5 / 5
        static let multiplierSide: CGFloat = 0.5 / 5
        static let textSize: CGFloat = 18
        
        static let textFont: String = "Apple SD Gothic Neo UltraLight"
        static let instrument: String = "Instrument"
        static let price: String = "Price"
        static let amount: String = "Amount"
        static let side: String = "Side"
        
    }
}
