//
//  ToastMessage.swift
//  Kidsnote_Pre_Project
//
//  Created by 김상혁 on 2023/11/08.
//

import Foundation


enum ToastMessage {
    case search(Search)
    
    var text: String {
        switch self {
        case .search(let search):
            switch search {
            case .failFetchingBookSearchResult:
                return "검색 결과를 불러오는 데 실패했습니다"
            case .successBookSearchResult:
                return "검색 결과를 성공적으로 불러왔습니다"
            }
        }
    }
}

extension ToastMessage {
    enum Search {
        case failFetchingBookSearchResult
        case successBookSearchResult
    }
}
 
