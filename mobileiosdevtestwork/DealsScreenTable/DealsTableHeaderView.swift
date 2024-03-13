//
//  DealsTableHeaderView.swift
//  mobileiosdevtestwork
//
//  Created by Aleksey Khlestkin on 13.03.2024.
//

import SnapKit

final class DealsTableHeaderView: UIView {
    
    // MARK: - Private properties
    
    private var instrument = UILabel(font: UIFont(name: "SFProDisplay-Regular", size: 11))
    private var price = UILabel(font: UIFont(name: "SFProDisplay-Regular", size: 11))
    private var amount = UILabel(font: UIFont(name: "SFProDisplay-Regular", size: 11))
    private var side = UILabel(font: UIFont(name: "SFProDisplay-Regular", size: 11))
    
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
        instrument.text = "Instrument"
        price.text = "Price"
        amount.text = "Amount"
        side.text = "Side"
        
        backgroundColor = UIColor.white
    }
    
    private func setupSubViews() {
        
    }
    
    private func setupConstraint() {
        
        
    }
    
}

