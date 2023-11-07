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
        static let eBook = "ebook"
        static let allEbooks = "전체 eBook"
        static let freeEbooks = "무료 eBook"
        static let sarchInPlayBook = "Play 북에서 검색"
        static let googlePlaySearchResult = "Google Play 검색결과"
        static let searchResultEmpty = "검색결과 없음"
    }
}
