//
//  AladinAPI.swift
//  Kidsnote_Pre_Project
//
//  Created by 김상혁 on 2023/11/09.
//

import Foundation

enum AladinAPI {
    case fetchBookRating(isbn13Id: String)
}

extension AladinAPI: TargetType {
    var baseURL: URL? {
        return URL(string: "http://www.aladin.co.kr")
    }
    
    var path: String {
        switch self {
        case .fetchBookRating:
            return "/ttb/api/ItemLookUp.aspx"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .fetchBookRating:
            return .get
        }
    }
    
    var headers: [String: String]? {
        return nil // 알라딘 API는 헤더를 요구하지 않습니다.
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .fetchBookRating(let isbn13Id):
            return [
                "TTBKEY": "ttbslsnsi1745001",
                "itemId": isbn13Id,
                "ItemIdType": "ISBN13",
                "output": "JS",
                "OptResult": "ratingInfo,reviewList"
            ]
        }
    }
}

