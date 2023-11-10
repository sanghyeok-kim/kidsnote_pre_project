//
//  DetaultBookDetailInfoRepository.swift
//  Kidsnote_Pre_Project
//
//  Created by 김상혁 on 2023/11/10.
//

import Foundation

import RxSwift

final class DetaultBookDetailInfoRepository: BookDetailInfoRepository {
    
    @Injected(AppDIContainer.shared) private var urlSessionNetworkService: URLSessionNetworkService
    @Injected(AppDIContainer.shared) private var bookDetailInfoEntityMapper: AnyDataMapper<BookDescriptionDetailDTO, BookDetailInfoEntity>
    
    func fetchBookDetailInfo(bookId: String) -> Single<BookDetailInfoEntity> {
        return urlSessionNetworkService
            .fetchData(target: GoogleBooksAPI.fetchBookDetailInfo(bookId: bookId))
            .decodeMap(BookDescriptionDetailDTO.self)
            .transformMap(bookDetailInfoEntityMapper)
    }
}
