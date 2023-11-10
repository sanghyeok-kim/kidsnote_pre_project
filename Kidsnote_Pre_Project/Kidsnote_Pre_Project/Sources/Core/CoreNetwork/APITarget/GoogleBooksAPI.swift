//
//  GoogleBooksAPI.swift
//  Kidsnote_Pre_Project
//
//  Created by 김상혁 on 2023/11/03.
//

import Foundation

enum GoogleBooksAPI {
    case searchAllEbooks(keyword: String, startIndex: Int, maxResults: Int)
    case searchFreeEbooks(keyword: String, startIndex: Int, maxResults: Int)
    case fetchBookDetailInfo(bookId: String)
}

extension GoogleBooksAPI: TargetType {
    var baseURL: URL? {
        return URL(string: "https://www.googleapis.com")
    }
    
    var path: String {
        switch self {
        case .searchAllEbooks, .searchFreeEbooks:
            return "books/v1/volumes"
        case .fetchBookDetailInfo(let bookId):
            return "books/v1/volumes/\(bookId)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .searchAllEbooks, .searchFreeEbooks, .fetchBookDetailInfo:
            return .get
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .searchAllEbooks, .searchFreeEbooks, .fetchBookDetailInfo:
            return nil
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .searchAllEbooks(let keyword, let startIndex, let maxResults):
            return [
                "q": keyword,
                "filter": "ebooks",
                "startIndex": startIndex,
                "maxResults": maxResults,
            ]
        case .searchFreeEbooks(let keyword, let startIndex, let maxResults):
            return [
                "q": keyword,
                "filter": "free-ebooks",
                "startIndex": startIndex,
                "maxResults": maxResults,
            ]
        case .fetchBookDetailInfo:
            return nil
        }
    }
}
