//
//  Constant.swift
//  Kidsnote_Pre_Project
//
//  Created by 김상혁 on 2023/11/03.
//

import Foundation

public enum Constant { }

// MARK: - OSLogCategory

public extension Constant {
    enum OSLogCategory {
        public static let `default` = "Default"
        public static let deallocation = "Deallocation"
        public static let bundle = "Bundle"
        public static let network = "Network"
        public static let storage = "Storage"
    }
}
