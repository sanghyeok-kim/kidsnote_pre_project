//
//  Logger.swift
//  Kidsnote_Pre_Project
//
//  Created by 김상혁 on 2023/11/03.
//

import Foundation
import OSLog

public struct Logger {
    public static func log(message: String, category: OSLog.LogCategory, type: OSLogType) {
        #if DEBUG
        let log = OSLog(subsystem: OSLog.subsystem, category: category.value)
        os_log(type, log: log, "[🔖] \(message)")
        #endif
    }
    
    public static func logDeallocation<T: AnyObject>(object: T) {
        #if DEBUG
        let log = OSLog(subsystem: OSLog.subsystem, category: OSLog.LogCategory.deallocation.value)
        let objectDescription = String(describing: object)
        os_log(.info, log: log, "[🗑️] \(objectDescription)")
        #endif
    }
}
