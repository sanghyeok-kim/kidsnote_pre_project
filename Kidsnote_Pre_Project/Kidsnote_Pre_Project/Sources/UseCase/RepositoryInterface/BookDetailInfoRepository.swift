//
//  BookDetailInfoRepository.swift
//  Kidsnote_Pre_Project
//
//  Created by 김상혁 on 2023/11/10.
//

import Foundation

import RxSwift

protocol BookDetailInfoRepository {
    func fetchBookDetailInfo(bookId: String) -> Single<BookDetailInfoEntity>
}
