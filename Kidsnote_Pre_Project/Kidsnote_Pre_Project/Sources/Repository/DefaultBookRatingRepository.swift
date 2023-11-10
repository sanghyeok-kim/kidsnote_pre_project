//
//  DefaultBookRatingRepository.swift
//  Kidsnote_Pre_Project
//
//  Created by 김상혁 on 2023/11/09.
//

import Foundation

import RxSwift

final class DefaultBookRatingRepository: BookRatingRepository {
    
    @Injected(AppDIContainer.shared) private var urlSessionNetworkService: URLSessionNetworkService
    @Injected(AppDIContainer.shared) private var bookReviewInfoEntityMapper: AnyDataMapper<AladinBookDetailInfoDTO, BookReviewInfoEntity>
    
    func fetchBookRating(isbn13Id: String) -> Single<BookReviewInfoEntity> {
        return urlSessionNetworkService
            .fetchData(target: AladinAPI.fetchBookRating(isbn13Id: isbn13Id))
            .decodeJsonStringMap(AladinBookDetailInfoDTO.self)
            .transformMap(bookReviewInfoEntityMapper)
    }
}
