//
//  ToastMessage.swift
//  Kidsnote_Pre_Project
//
//  Created by 김상혁 on 2023/11/08.
//

import Foundation


enum ToastMessage {
    case search(Search)
    case bookDetail(BookDetail)
    
    var text: String {
        switch self {
        case .search(let search):
            switch search {
            case .failFetchingBookSearchResult:
                return "검색 결과를 불러오는 데 실패했습니다"
            case .successBookSearchResult:
                return "검색 결과를 성공적으로 불러왔습니다"
            }
        case .bookDetail(let bookDetail):
            switch bookDetail {
            case .failOpenSampleURL:
                return "샘플 URL을 열 수 없습니다"
            case .successOpenSampleURL:
                return "샘플 URL을 성공적으로 열었습니다"
            case .failOpenDownloadURL:
                return "다운로드 URL을 열 수 없습니다"
            case .successOpenDownloadURL:
                return "다운로드 URL을 성공적으로 열었습니다"
            }
        }
    }
}

extension ToastMessage {
    enum Search {
        case failFetchingBookSearchResult
        case successBookSearchResult
    }
    
    enum BookDetail {
        case failOpenSampleURL
        case successOpenSampleURL
        case failOpenDownloadURL
        case successOpenDownloadURL
    }
}
 
