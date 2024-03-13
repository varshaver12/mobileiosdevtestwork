//
//  DealTableViewCell.swift
//  mobileiosdevtestwork
//
//  Created by Aleksey Khlestkin on 13.03.2024.
//

import SnapKit

// MARK: - DealsScreenTableViewCell

final class DealTableViewCell: UITableViewCell {
    
    // MARK: - Private properties
    
    private let dateModifierLabel = UILabel(textColor: .gray,
                                            font: UIFont(name: "SFProDisplay-Regular", size: Constants.fontSize11))
    private let instrumentNameLabel = UILabel(textColor: .black,
                                              font: UIFont(name: "SFProDisplay-Regular", size: Constants.fontSize12))
    private let priceLabel = UILabel(textColor: .black,
                                     font: UIFont(name: "SFProDisplay-Regular", size: Constants.fontSize12))
    private let amountLabel = UILabel(textColor: .black,
                                      font: UIFont(name: "SFProDisplay-Regular", size: Constants.fontSize12))
    private let sideLabel = UILabel(textColor: .black,
                                    font: UIFont(name: "SFProDisplay-Regular", size: Constants.fontSize12))
    
    
    
    // MARK: - Life Cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupConfiguration()
        setupSubViews()
        setupConstraints()
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - IDealsScreenTableViewCell methods

extension DealTableViewCell: IDealTableViewCell {
    
    func setContent(deal: Deal) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss dd.MM.yyyy"
        dateModifierLabel.text = dateFormatter.string(from: deal.dateModifier)
        
        instrumentNameLabel.text = deal.instrumentName
        
        priceLabel.text = String((deal.price * Constants.double100).rounded() / Constants.double100)
        
        amountLabel.text = Int(deal.amount.rounded()).formattedWithSeparator()
        
        switch deal.side {
        case .sell:
            sideLabel.text = "Sell"
            sideLabel.textColor = .red
        case .buy:
            sideLabel.text = "Buy"
            sideLabel.textColor = .green
        }
    }
    
}

// MARK: - Private methods

private extension DealTableViewCell {
    
    func setupConfiguration() {
        contentView.layer.cornerRadius = 10 
        contentView.layer.masksToBounds = true
    }
    
    func setupSubViews() {
        
        contentView.addSubview(dateModifierLabel)
        contentView.addSubview(instrumentNameLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(amountLabel)
        contentView.addSubview(sideLabel)
    }
    
    func setupConstraints() {
        dateModifierLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().inset(Constants.inset20)
            $0.trailing.equalToSuperview().inset(Constants.inset20)
        }
        
        instrumentNameLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(Constants.inset20)
            $0.width.equalTo(LocalConstants.screenWidth * LocalConstants.multiplierInstrumentName)
            $0.top.equalTo(dateModifierLabel.snp.bottom).offset(Constants.offset4)
        }
        
        priceLabel.snp.makeConstraints {
            $0.leading.equalTo(instrumentNameLabel.snp.trailing)
            $0.width.equalTo(LocalConstants.screenWidth * LocalConstants.multiplierPrice)
            $0.top.equalTo(dateModifierLabel.snp.bottom).offset(Constants.offset4)
        }
        
        amountLabel.snp.makeConstraints {
            $0.leading.equalTo(priceLabel.snp.trailing)
            $0.width.equalTo(LocalConstants.screenWidth * LocalConstants.multiplierAmount)
            $0.top.equalTo(dateModifierLabel.snp.bottom).offset(Constants.offset4)
        }
        
        sideLabel.snp.makeConstraints {
            $0.leading.equalTo(amountLabel.snp.trailing)
            $0.width.equalTo(LocalConstants.screenWidth * LocalConstants.multiplierSide)
            $0.top.equalTo(dateModifierLabel.snp.bottom).offset(Constants.offset4)
            $0.trailing.equalToSuperview().inset(Constants.inset20)
        }
    }
    
}

private extension DealTableViewCell {
    enum LocalConstants {
        static let screenWidth = UIScreen.main.bounds.width - 40
        static let multiplierInstrumentName: CGFloat = 2 / 5
        static let multiplierPrice: CGFloat = 1 / 5
        static let multiplierAmount: CGFloat = 1.5 / 5
        static let multiplierSide: CGFloat = 0.5 / 5
    }
}
