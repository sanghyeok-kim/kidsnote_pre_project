//
//  NetworkResult.swift
//  Kidsnote_Pre_Project
//
//  Created by 김상혁 on 2023/11/03.
//

import Foundation

struct NetworkResult {
    let data: Data?
    let response: HTTPURLResponse
    
    var statusCode: Int {
        return response.statusCode
    }
    
    init(data: Data?, response: HTTPURLResponse) {
        self.data = data
        self.response = response
    }
}
