//
//  IDealTableViewCell.swift
//  mobileiosdevtestwork
//
//  Created by Aleksey Khlestkin on 13.03.2024.
//

import UIKit

protocol IDealTableViewCell: UITableViewCell {
    func setContent(deal: Deal)
}

