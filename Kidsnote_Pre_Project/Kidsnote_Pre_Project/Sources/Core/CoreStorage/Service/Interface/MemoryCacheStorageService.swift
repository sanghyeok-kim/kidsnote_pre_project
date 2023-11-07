//
//  MemoryCacheStorageService.swift
//  Kidsnote_Pre_Project
//
//  Created by 김상혁 on 2023/11/06.
//

import Foundation

public protocol MemoryCacheStorageService {
    func lookUpData(by key: String) -> Data?
    func storeData(_ data: Data, forKey key: String)
}
