//
//  DealsSorting.swift
//  mobileiosdevtestwork
//
//  Created by Aleksey Khlestkin on 13.03.2024.
//

import Foundation

enum DealsSorting {
    case dealModificationDate(sortOrder: SortOrder)
    case instrumentName(sortOrder: SortOrder)
    case dealPrice(sortOrder: SortOrder)
    case dealVolume(sortOrder: SortOrder)
    case dealSide(sortOrder: SortOrder)
    
    enum SortOrder {
        case ascending
        case descending
    }
}

