//
//  UILabel+Extensions.swift
//  mobileiosdevtestwork
//
//  Created by Aleksey Khlestkin on 13.03.2024.
//

import UIKit

extension UILabel {
    
    convenience init(text: String? = "",
                     textColor: UIColor? = UIColor.darkText,
                     font: UIFont? = UIFont(name: "SFProDisplay-Regular", size: 16),
                     isHidden: Bool? = false,
                     textAlignment: NSTextAlignment? = .left
    ) {
        self.init()
        self.text = text
        self.textColor = textColor
        self.font = font
        self.isHidden = isHidden ?? false
        self.textAlignment = textAlignment ?? .left
        self.adjustsFontSizeToFitWidth = true
        self.minimumScaleFactor = 0.5
        self.numberOfLines = 1
        self.lineBreakMode = .byWordWrapping
    }
    
}
