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
    
    func searchBooks(keyword: String, startIndex: Int, maxResults: Int) -> Observable<[BookEntity]> {
        return searchBookRepository
            .searchBooks(keyword: keyword, startIndex: startIndex, maxResults: maxResults)
            .logErrorIfDetected(category: .network)
            .asObservable()
    }
}
