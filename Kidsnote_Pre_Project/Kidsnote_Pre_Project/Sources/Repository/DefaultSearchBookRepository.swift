//
//  DefaultSearchBookRepository.swift
//  Kidsnote_Pre_Project
//
//  Created by 김상혁 on 2023/11/03.
//

import Foundation

import RxSwift

final class DefaultSearchBookRepository: SearchBookRepository {
    
    @Injected(AppDIContainer.shared) private var urlSessionNetworkService: URLSessionNetworkService
    @Injected(AppDIContainer.shared) private var bookEntityMapper: AnyDataMapper<BookSearchResultDTO, [BookEntity]>
    
    func searchAllEbooks(keyword: String, startIndex: Int, maxResults: Int) -> Single<[BookEntity]> {
        return urlSessionNetworkService.fetchData(target: GoogleBooksAPI.searchAllEbooks(
            keyword: keyword,
            startIndex: startIndex,
            maxResults: maxResults
        ))
        .decodeMap(BookSearchResultDTO.self)
        .transformMap(bookEntityMapper)
    }
    
    func searchFreeEbooks(keyword: String, startIndex: Int, maxResults: Int) -> Single<[BookEntity]> {
        return urlSessionNetworkService.fetchData(target: GoogleBooksAPI.searchFreeEbooks(
            keyword: keyword,
            startIndex: startIndex,
            maxResults: maxResults
        ))
        .decodeMap(BookSearchResultDTO.self)
        .transformMap(bookEntityMapper)
    }
}
