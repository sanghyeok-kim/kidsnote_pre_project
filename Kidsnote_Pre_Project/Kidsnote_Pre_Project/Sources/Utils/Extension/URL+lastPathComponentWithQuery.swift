//
//  URL+lastPathComponentWithQuery.swift
//  Kidsnote_Pre_Project
//
//  Created by 김상혁 on 2023/11/07.
//

import Foundation

extension URL {
    var lastPathComponentWithQuery: String {
        var nameWithQuery = lastPathComponent
        if let query = query {
            nameWithQuery += "-\(query)"
        }
        
        let maxFileNameLength = 255
        if nameWithQuery.count > maxFileNameLength {
            return String(nameWithQuery.prefix(maxFileNameLength))
        }
        
        return nameWithQuery
    }
}
