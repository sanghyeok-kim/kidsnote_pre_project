//
//  SearchBookUseCase.swift
//  Kidsnote_Pre_Project
//
//  Created by 김상혁 on 2023/11/05.
//

import Foundation

import RxSwift

protocol SearchBookUseCase {
    func searchBooks(keyword: String, startIndex: Int, maxResults: Int) -> Observable<[BookEntity]>
}
