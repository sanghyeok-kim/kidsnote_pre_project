//
//  FileSystemError.swift
//  Kidsnote_Pre_Project
//
//  Created by 김상혁 on 2023/11/06.
//

import Foundation

public enum FileSystemError: LocalizedError {
    case errorDetected(error: Error)
    case objectDeallocated
    case invalidFilePath
    case dataNotFound
    
    public var errorDescription: String? {
        switch self {
        case .errorDetected(let error):
            return "Error detected: \(error.localizedDescription)"
        case .objectDeallocated:
            return "Object Deallocated."
        case .invalidFilePath:
            return "Invalid File Path"
        case .dataNotFound:
            return "Fail to Find Data"
        }
    }
}
