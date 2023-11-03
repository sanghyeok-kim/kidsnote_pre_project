//
//  OSLog+category.swift
//  Kidsnote_Pre_Project
//
//  Created by 김상혁 on 2023/11/03.
//

import Foundation
import OSLog

public extension OSLog {
    static let subsystem = Bundle.main.bundleIdentifier ?? ""
    
    enum LogCategory {
        case `default`
        case bundle
        case deallocation
        case network
        case storage
        
        var value: String {
            switch self {
            case .`default`:
                return Constant.OSLogCategory.`default`
            case .bundle:
                return Constant.OSLogCategory.bundle
            case .deallocation:
                return Constant.OSLogCategory.deallocation
            case .network:
                return Constant.OSLogCategory.network
            case .storage:
                return Constant.OSLogCategory.storage
            }
        }
    }
}
