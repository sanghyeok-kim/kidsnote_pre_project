//
//  BookSearchType.swift
//  Kidsnote_Pre_Project
//
//  Created by 김상혁 on 2023/11/07.
//

import Foundation

enum BookSearchType: Int, CaseIterable {
    case allEbooks
    case freeEbooks
    
    var index: Int {
        return rawValue
    }
    
    var title: String {
        switch self {
        case .allEbooks:
            return Literal.Text.allEbooks.appString
        case .freeEbooks:
            return Literal.Text.freeEbooks.appString
        }
    }
    
    static var segmentTitles: [String] {
        return Self.allCases.map { $0.title }
    }
}
