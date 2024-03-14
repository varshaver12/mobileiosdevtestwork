//
//  DealsSorting.swift
//  mobileiosdevtestwork
//
//  Created by Aleksey Khlestkin on 13.03.2024.
//

import Foundation

enum DealsSorting: CaseIterable {
    case dealModificationDate
    case instrumentName
    case dealPrice
    case dealVolume
    case dealSide
    
    var sortName: String {
        switch self {
        case .dealModificationDate:
            return "Дата изменения сделки"
        case .instrumentName:
            return "Имя инструмента"
        case .dealPrice:
            return "Цена сделки"
        case .dealVolume:
            return "Объем сделки"
        case .dealSide:
            return "Сторона сделки"
        }
    }
    
    static var count: Int {
        return allCases.count
    }
}

enum SortOrder {
    case ascending
    case descending
    
    var orderName: String {
        switch self {
        case .ascending:
            return "По возрастанию"
        case .descending:
            return "По убыванию"
        }
    }
    
}

