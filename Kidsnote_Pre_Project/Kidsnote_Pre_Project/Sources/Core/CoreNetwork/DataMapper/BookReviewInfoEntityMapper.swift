//
//  BookReviewInfoEntityMapper.swift
//  Kidsnote_Pre_Project
//
//  Created by 김상혁 on 2023/11/10.
//

import Foundation

struct BookReviewInfoEntityMapper: DataMapper {
    func transform(_ dto: AladinBookDetailInfoDTO) throws -> BookReviewInfoEntity {
        guard let dtoItem = dto.item.first, let customerReviewRank = dtoItem.customerReviewRank else {
            throw NetworkError.dataMappingError
        }
        return BookReviewInfoEntity(customerReviewRank: customerReviewRank)
    }
}
