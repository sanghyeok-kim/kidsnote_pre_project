//
//  NSCacheMemoryCacheStorageService.swift
//  Kidsnote_Pre_Project
//
//  Created by 김상혁 on 2023/11/06.
//

import Foundation

public final class NSCacheMemoryCacheStorageService: MemoryCacheStorageService {
    
    public static let shared = NSCacheMemoryCacheStorageService()
    
    private let cache = NSCache<NSString, NSData>()
    
    private init() { }
   
    public func lookUpData(by key: String) -> Data? {
        let cachedData = cache.object(forKey: key as NSString)
        return cachedData as Data?
    }
    
    public func storeData(_ data: Data, forKey key: String) {
        cache.setObject(data as NSData, forKey: key as NSString, cost: data.count)
    }
}
