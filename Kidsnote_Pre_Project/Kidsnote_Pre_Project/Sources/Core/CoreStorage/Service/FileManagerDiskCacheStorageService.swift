//
//  FileManagerDiskCacheStorageService.swift
//  Kidsnote_Pre_Project
//
//  Created by 김상혁 on 2023/11/06.
//

import Foundation

import RxSwift

public final class FileManagerDiskCacheStorageService: DiskCacheStorageService {
    
    public static let shared = FileManagerDiskCacheStorageService()
    
    private let fileManager = FileManager.default
    private let diskCacheDirectoryUrl: URL? = {
        return FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first
    }()
    
    private init() { }
    
    public func lookUpData(by key: String) -> Single<Data> {
        return Single<Data>.create { [weak self] single in
            DispatchQueue.global(qos: .userInitiated).async {
                guard let self else {
                    single(.failure(FileSystemError.objectDeallocated))
                    return
                }
                
                guard let filePath = self.diskCacheDirectoryUrl?.appendingPathComponent(key) else {
                    single(.failure(FileSystemError.invalidFilePath))
                    return
                }
                
                if self.fileManager.fileExists(atPath: filePath.path),
                   let data = try? Data(contentsOf: filePath) {
                    single(.success(data))
                } else {
                    single(.failure(FileSystemError.dataNotFound))
                }
            }
            
            return Disposables.create()
        }
    }
    
    public func storeData(_ data: Data, forKey key: String) {
        DispatchQueue.global(qos: .background).async {
            guard let diskCacheDirectoryUrl = self.diskCacheDirectoryUrl else { return }
            let filePath = diskCacheDirectoryUrl.appendingPathComponent(key)
            do {
                try data.write(to: filePath)
            } catch {
                Logger.log(message: error.localizedDescription, category: .storage, type: .error)
            }
        }
    }
}
