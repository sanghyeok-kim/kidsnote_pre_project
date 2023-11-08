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
    
    init() { }
    
    func searchBooks(
        keyword: String,
        bookSearchType: BookSearchType,
        startIndex: Int,
        maxResults: Int
    ) -> Observable<[BookEntity]> {
        switch bookSearchType {
        case .allEbooks:
            return searchBookRepository
                .searchAllEbooks(keyword: keyword, startIndex: startIndex, maxResults: maxResults)
                .logErrorIfDetected(category: .network)
                .asObservable()
        case .freeEbooks:
            return searchBookRepository
                .searchFreeEbooks(keyword: keyword, startIndex: startIndex, maxResults: maxResults)
                .logErrorIfDetected(category: .network)
                .asObservable()
        }
    }
}
