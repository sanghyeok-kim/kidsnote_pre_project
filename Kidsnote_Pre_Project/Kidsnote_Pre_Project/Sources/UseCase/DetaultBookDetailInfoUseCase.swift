//
//  DetaultBookDetailInfoUseCase.swift
//  Kidsnote_Pre_Project
//
//  Created by 김상혁 on 2023/11/10.
//

import Foundation

import RxSwift

final class DetaultBookDetailInfoUseCase: BookDetailInfoUseCase {
    
    @Injected(AppDIContainer.shared) private var bookDetailInfoRepository: BookDetailInfoRepository
    
    func fetchBookDetailInfo(bookId: String) -> Observable<BookDetailInfoEntity> {
        return bookDetailInfoRepository
            .fetchBookDetailInfo(bookId: bookId)
            .asObservable()
            .logErrorIfDetected(category: .network)
    }
}
