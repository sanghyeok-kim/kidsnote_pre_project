//
//  SearchBookRepository.swift
//  Kidsnote_Pre_Project
//
//  Created by 김상혁 on 2023/11/05.
//

import Foundation

import RxSwift

protocol SearchBookRepository {
    func searchAllEbooks(keyword: String, startIndex: Int, maxResults: Int) -> Single<[BookEntity]>
    func searchFreeEbooks(keyword: String, startIndex: Int, maxResults: Int) -> Single<[BookEntity]>
}
