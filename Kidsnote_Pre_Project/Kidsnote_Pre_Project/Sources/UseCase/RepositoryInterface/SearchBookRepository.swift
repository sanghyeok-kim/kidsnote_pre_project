//
//  SearchBookRepository.swift
//  Kidsnote_Pre_Project
//
//  Created by 김상혁 on 2023/11/05.
//

import Foundation

import RxSwift

protocol SearchBookRepository {
    func searchBooks(keyword: String, startIndex: Int, maxResults: Int) -> Single<[BookEntity]>
}
