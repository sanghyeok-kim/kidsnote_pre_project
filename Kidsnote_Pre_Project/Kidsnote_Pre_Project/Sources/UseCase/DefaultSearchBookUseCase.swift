//
//  DefaultSearchBookUseCase.swift
//  Kidsnote_Pre_Project
//
//  Created by 김상혁 on 2023/11/05.
//

import Foundation

import RxSwift

final class DefaultSearchBookUseCase: SearchBookUseCase {
    
    @Injected(AppDIContainer.shared) private var searchBookRepository: SearchBookRepository
    
    func searchBooks(
        keyword: String,
        bookSearchType: BookSearchType,
        paginationState: PaginationState
    ) -> Observable<[BookEntity]> {
        switch bookSearchType {
        case .allEbooks:
            return searchBookRepository
                .searchAllEbooks(
                    keyword: keyword,
                    startIndex: paginationState.currentIndex,
                    maxResults: paginationState.maxResultCount
                )
                .logErrorIfDetected(category: .network)
                .asObservable()
        case .freeEbooks:
            return searchBookRepository
                .searchFreeEbooks(
                    keyword: keyword,
                    startIndex: paginationState.currentIndex,
                    maxResults: paginationState.maxResultCount
                )
                .logErrorIfDetected(category: .network)
                .asObservable()
        }
    }
}
