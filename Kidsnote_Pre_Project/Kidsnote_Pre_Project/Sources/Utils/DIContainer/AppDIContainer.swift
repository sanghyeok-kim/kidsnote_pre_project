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
        
    }
}
