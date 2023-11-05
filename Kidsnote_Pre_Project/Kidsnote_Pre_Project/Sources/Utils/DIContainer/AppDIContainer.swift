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
        // Core
        AppDIContainer.shared.register(service: URLSessionNetworkService.self) {
            URLSessionNetworkService.shared
        }
        
        // DataMapper
        AppDIContainer.shared.register(service: AnyDataMapper.self) {
            AnyDataMapper(BookEntityMapper())
        }
        
        // Repository
        AppDIContainer.shared.register(service: SearchBookRepository.self) {
            DefaultSearchBookRepository()
        }
        
        // UseCase
        AppDIContainer.shared.register(service: SearchBookUseCase.self) {
            DefaultSearchBookUseCase()
        }
    }
}
