//
//  AppDIContainer.swift
//  Kidsnote_Pre_Project
//
//  Created by 김상혁 on 2023/11/05.
//

import Foundation

final class AppDIContainer: DIContainer {
    
    static let shared = AppDIContainer()
    var storage: [String: Any] = [:]
    
    private init() { }
}

extension AppDIContainer {
    func registerDependencies() {
        
        // MARK: - Register Core Service
        
        AppDIContainer.shared.register(service: URLDataService.self) {
            URLSessionURLDataService.shared
        }
        AppDIContainer.shared.register(service: URLSessionNetworkService.self) {
            URLSessionNetworkService.shared
        }
        AppDIContainer.shared.register(service: ImageLoadService.self) {
            CachedImageLoadService()
        }
        AppDIContainer.shared.register(service: MemoryCacheStorageService.self) {
            NSCacheMemoryCacheStorageService.shared
        }
        AppDIContainer.shared.register(service: DiskCacheStorageService.self) {
            FileManagerDiskCacheStorageService.shared
        }
        
        // MARK: - Register DataMapper
        
        AppDIContainer.shared.register(service: AnyDataMapper.self) {
            AnyDataMapper(BookEntityMapper())
        }
        
        // MARK: - Register Repository
        
        AppDIContainer.shared.register(service: SearchBookRepository.self) {
            DefaultSearchBookRepository()
        }
        
        // MARK: - Register UseCase
        
        AppDIContainer.shared.register(service: SearchBookUseCase.self) {
            DefaultSearchBookUseCase()
        }
    }
}
