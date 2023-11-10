//
//  BookRatingUseCase.swift
//  Kidsnote_Pre_Project
//
//  Created by 김상혁 on 2023/11/10.
//

import Foundation

import RxSwift

protocol BookRatingUseCase {
    func fetchBookRating(isbn13Id: String) -> Observable<BookReviewInfoEntity>
}
