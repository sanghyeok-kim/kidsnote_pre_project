//
//  DefaultBookRatingUseCase.swift
//  Kidsnote_Pre_Project
//
//  Created by 김상혁 on 2023/11/10.
//

import Foundation

import RxSwift

final class DefaultBookRatingUseCase: BookRatingUseCase {
    
    @Injected(AppDIContainer.shared) private var bookRatingRepository: BookRatingRepository
    
    func fetchBookRating(isbn13Id: String) -> Observable<BookReviewInfoEntity> {
        return bookRatingRepository
            .fetchBookRating(isbn13Id: isbn13Id)
            .asObservable()
            .logErrorIfDetected(category: .network)
    }
}
