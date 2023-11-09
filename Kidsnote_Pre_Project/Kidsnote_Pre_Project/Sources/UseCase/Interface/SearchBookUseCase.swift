//
//  SearchBookUseCase.swift
//  Kidsnote_Pre_Project
//
//  Created by 김상혁 on 2023/11/05.
//

import Foundation

import RxSwift

protocol SearchBookUseCase {
    func searchBooks(
        keyword: String,
        bookSearchType: BookSearchType,
        paginationState: PaginationState
    ) -> Observable<[BookEntity]>
}
