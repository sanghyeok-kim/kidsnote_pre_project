//
//  DataMapper.swift
//  Kidsnote_Pre_Project
//
//  Created by 김상혁 on 2023/11/03.
//

import Foundation

public protocol DataMapper {
    associatedtype Input
    associatedtype Output

    func transform(_ input: Input) throws -> Output
}
