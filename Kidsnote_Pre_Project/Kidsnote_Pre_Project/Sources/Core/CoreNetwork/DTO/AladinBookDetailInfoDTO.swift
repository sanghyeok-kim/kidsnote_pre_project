//
//  AladinBookDetailInfoDTO.swift
//  Kidsnote_Pre_Project
//
//  Created by 김상혁 on 2023/11/10.
//

import Foundation

struct AladinBookDetailInfoDTO: Decodable {
    let item: [BookDetailInfo]
}

extension AladinBookDetailInfoDTO {
    struct BookDetailInfo: Decodable {
        let customerReviewRank: Int?
    }
}
