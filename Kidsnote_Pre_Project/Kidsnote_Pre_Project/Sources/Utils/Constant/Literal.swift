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
        case dot
        case readbleInGooglePlay
        case reviewRankProviderAladin
        case eBookInfo
        case noDescriptionYet
        case notReviewedYet
        case readSample
        case download
        case publishDate
        case page(Int)
        case back
        
        
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
            case .dot:
                return "•"
            case .readbleInGooglePlay:
                return "Google Play 웹사이트에서 구매한 책을 이 앱에서 읽을 수 있습니다."
            case .reviewRankProviderAladin:
                return "(평점 제공: 알라딘)"
            case .eBookInfo:
                return "eBook 정보"
            case .noDescriptionYet:
                return "아직 작성된 설명이 없습니다."
            case .notReviewedYet:
                return "아직 기록된 평점이 없습니다."
            case .readSample:
                return "샘플 읽기"
            case .download:
                return "다운로드"
            case .publishDate:
                return "게시일"
            case .page(let page):
                return "\(page) 페이지"
            case .back:
                return "뒤로"
                
            }
        }
    }
}
