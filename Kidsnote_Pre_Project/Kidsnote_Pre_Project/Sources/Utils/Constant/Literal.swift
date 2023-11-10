//
//  Literal.swift
//  Kidsnote_Pre_Project
//
//  Created by 김상혁 on 2023/11/03.
//

import Foundation

enum Literal { }

// MARK: - OSLogCategory

extension Literal {
    enum OSLogCategory {
        static let `default` = "Default"
        static let deallocation = "Deallocation"
        static let bundle = "Bundle"
        static let network = "Network"
        static let storage = "Storage"
    }
}

extension Literal {
    enum Text {
        case eBook
        case allEbooks
        case freeEbooks
        case sarchInPlayBook
        case googlePlaySearchResult
        case searchResultEmpty
        
        
        var appString: String {
            switch self {
            case .eBook:
                return "ebook"
            case .allEbooks:
                return "전체 eBook"
            case .freeEbooks:
                return "무료 eBook"
            case .sarchInPlayBook:
                return "Play 북에서 검색"
            case .googlePlaySearchResult:
                return "Google Play 검색결과"
            case .searchResultEmpty:
                return "검색결과 없음"
            }
        }
    }
}
