//
//  Int+Extensions.swift
//  mobileiosdevtestwork
//
//  Created by Aleksey Khlestkin on 13.03.2024.
//

import Foundation

extension Int {
    func formattedWithSeparator() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = " "
        return formatter.string(from: NSNumber(value: self)) ?? ""
    }
}
