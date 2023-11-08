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
}

extension GoogleBooksAPI: TargetType {
    var baseURL: URL? {
        return URL(string: "https://www.googleapis.com")
    }
    
    var path: String {
        switch self {
        case .searchAllEbooks, .searchFreeEbooks:
            return "books/v1/volumes"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .searchAllEbooks, .searchFreeEbooks:
            return .get
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .searchAllEbooks, .searchFreeEbooks:
            return nil
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .searchAllEbooks(let keyword, let startIndex, let maxResults):
            return [
                "q": keyword,
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
        }
    }
}
