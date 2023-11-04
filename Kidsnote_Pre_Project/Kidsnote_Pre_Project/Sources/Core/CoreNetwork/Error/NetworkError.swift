//
//  NetworkError.swift
//  Kidsnote_Pre_Project
//
//  Created by 김상혁 on 2023/11/03.
//

import Foundation

public enum NetworkError: LocalizedError {
    case errorDetected(error: Error)
    case objectDeallocated
    case invalidURL
    case invalidResponse
    case invalidStatusCode(code: Int)
    case invalidResponseData
    case invalidRequest
    case decodeError
    case encodeError
    case dataMappingError
    
    public var errorDescription: String? {
        switch self {
        case .errorDetected(let error):
            return "Error detected: \(error.localizedDescription)"
        case .objectDeallocated:
            return "Object deallocated."
        case .invalidURL:
            return "Invalid URL."
        case .invalidResponse:
            return "Invaild response."
        case .invalidStatusCode(let code):
            return "Invalid status code: \(code)"
        case .invalidResponseData:
            return "Invalid response data."
        case .invalidRequest:
            return "Invalid request."
        case .decodeError:
            return "Fail to decode."
        case .encodeError:
            return "Fail to encode."
        case .dataMappingError:
            return "Fail to map data."
        }
    }
}
