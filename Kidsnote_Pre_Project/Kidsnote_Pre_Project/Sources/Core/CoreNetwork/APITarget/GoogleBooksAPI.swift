//
//  GoogleBooksAPI.swift
//  Kidsnote_Pre_Project
//
//  Created by 김상혁 on 2023/11/03.
//

import Foundation

enum GoogleBooksAPI {
    case searchBooks(keyword: String, startIndex: Int, maxResults: Int)
}

extension GoogleBooksAPI: TargetType {
    var baseURL: URL? {
        return URL(string: "https://www.googleapis.com")
    }
    
    var path: String {
        switch self {
        case .searchBooks:
            return "books/v1/volumes"
        }
    }
        
    var method: HTTPMethod {
        switch self {
        case .searchBooks:
            return .get
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .searchBooks:
            return nil
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .searchBooks(let keyword, let startIndex, let maxResults):
            return [
                "q": keyword,
                "startIndex": startIndex,
                "maxResults": maxResults,
            ]
        }
    }
}
