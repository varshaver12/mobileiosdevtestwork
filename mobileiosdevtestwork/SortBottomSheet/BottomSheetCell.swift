//
//  BottomSheetCell.swift
//  mobileiosdevtestwork
//
//  Created by Aleksey Khlestkin on 13.03.2024.
//

import SnapKit

protocol IBottomSheetCell: UITableViewCell {
    func setContent(nameSort: String, isSelected: Bool)
}

// MARK: - DealsScreenTableViewCell

final class BottomSheetCell: UITableViewCell {
    
    // MARK: - Private properties
    
    private let nameSortLabel = UILabel(textColor: .black,
                                        font: UIFont(name: LocalConstants.textFont,
                                                     size: LocalConstants.textSize))
    private let checkmark: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: LocalConstants.checkmark))
        imageView.tintColor = UIColor.systemBlue
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    
    // MARK: - Life Cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupSubViews()
        setupConstraints()
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - IDealsScreenTableViewCell methods

extension BottomSheetCell: IBottomSheetCell {
    
    func setContent(nameSort: String, isSelected: Bool) {
        nameSortLabel.text = nameSort
        checkmark.isHidden = isSelected ? false : true
    }
    
}

// MARK: - Private methods

private extension BottomSheetCell {
    
    func setupSubViews() {
        
        contentView.addSubview(nameSortLabel)
        contentView.addSubview(checkmark)
    }
    
    func setupConstraints() {
        nameSortLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().inset(Constants.inset20)
            $0.bottom.equalToSuperview()
        }
        checkmark.snp.makeConstraints {
            $0.width.equalTo(LocalConstants.checkmarkSize)
            $0.top.equalToSuperview()
            $0.leading.equalTo(nameSortLabel.snp.trailing)
            $0.trailing.equalToSuperview().inset(Constants.inset20)
            $0.bottom.equalToSuperview()
        }
    }
    
}

private extension BottomSheetCell {
    enum LocalConstants {
        static let checkmarkSize: CGFloat = 25
        static let textSize: CGFloat = 18
        static let textFont: String = "Apple SD Gothic Neo UltraLight"
        static let checkmark: String = "checkmark"
    }
}

