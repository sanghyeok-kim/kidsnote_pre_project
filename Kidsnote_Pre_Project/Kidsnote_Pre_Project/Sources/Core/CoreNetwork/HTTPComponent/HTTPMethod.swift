//
//  HTTPMethod.swift
//  Kidsnote_Pre_Project
//
//  Created by 김상혁 on 2023/11/03.
//

import Foundation

enum HTTPMethod: String {
    case get
    case post
    case put
    case delete
    
    var value: String {
        return rawValue.uppercased()
    }
}
