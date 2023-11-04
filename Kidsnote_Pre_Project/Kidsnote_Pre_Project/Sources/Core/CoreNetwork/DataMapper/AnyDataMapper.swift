//
//  AnyDataMapper.swift
//  Kidsnote_Pre_Project
//
//  Created by 김상혁 on 2023/11/03.
//

import Foundation

public struct AnyDataMapper<Input, Output>: DataMapper {
    private let _transform: (_: Input) throws -> Output

    public init<T: DataMapper>(_ mapper: T) where T.Input == Input, T.Output == Output {
        self._transform = mapper.transform
    }

    public func transform(_ input: Input) throws -> Output {
        return try _transform(input)
    }
}
