//
//  CachedURLDataRepository.swift
//  Kidsnote_Pre_Project
//
//  Created by 김상혁 on 2023/11/07.
//

import Foundation

import RxSwift

final class CachedImageLoadService: ImageLoadService {
    
    @Injected(AppDIContainer.shared) private var memoryCacheStorageService: MemoryCacheStorageService
    @Injected(AppDIContainer.shared) private var diskCacheStorageService: DiskCacheStorageService
    @Injected(AppDIContainer.shared) private var urlDataService: URLDataService
    
    func fetchImage(from url: URL?) -> Observable<UIImage?> {
        return fetchCachedData(from: url)
            .asObservable()
            .transformToUIImage()
            .logErrorIfDetected(category: .network)
    }
}

// MARK: - Supporting Methods

private extension CachedImageLoadService {
    func fetchCachedData(from url: URL?) -> Single<Data> {
        guard let url = url else {
            return Single.error(NetworkError.invalidURL)
        }
        
        let dataName = url.lastPathComponentWithQuery
        
        return fetchFromMemoryCache(dataName: dataName)
            .catch { [weak self] _ in
                guard let self else { return .error(FileSystemError.objectDeallocated) }
                return self.fetchFromDiskCache(dataName: dataName)
            }
            .catch { [weak self] _ in
                guard let self else { return .error(FileSystemError.objectDeallocated) }
                return self.fetchFromRemoteAndStoreCache(from: url, dataName: dataName)
            }
    }
    
    func fetchFromMemoryCache(dataName: String) -> Single<Data> {
        return Single.create { [weak self] single in
            guard let self else {
                single(.failure(FileSystemError.objectDeallocated))
                return Disposables.create()
            }
            
            if let data = self.memoryCacheStorageService.lookUpData(by: dataName) {
                single(.success(data))
            } else {
                single(.failure(FileSystemError.dataNotFound))
            }
            
            return Disposables.create()
        }
    }
    
    func fetchFromDiskCache(dataName: String) -> Single<Data> {
        return diskCacheStorageService
            .lookUpData(by: dataName)
            .do(onSuccess: { [weak self] data in
                self?.memoryCacheStorageService.storeData(data, forKey: dataName)
            })
    }
    
    func fetchFromRemoteAndStoreCache(from url: URL, dataName: String) -> Single<Data> {
        return urlDataService.fetchData(from: url)
            .do(onSuccess: { [weak self] data in
                self?.memoryCacheStorageService.storeData(data, forKey: dataName)
                self?.diskCacheStorageService.storeData(data, forKey: dataName)
            })
    }
}
