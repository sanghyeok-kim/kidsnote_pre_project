//
//  DiskCacheStorageService.swift
//  Kidsnote_Pre_Project
//
//  Created by 김상혁 on 2023/11/06.
//

import Foundation

import RxSwift

public protocol DiskCacheStorageService {
    func lookUpData(by key: String) -> Single<Data>
    func storeData(_ data: Data, forKey key: String)
}
