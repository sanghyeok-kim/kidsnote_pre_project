//
//  Injected.swift
//  Kidsnote_Pre_Project
//
//  Created by 김상혁 on 2023/11/05.
//

import Foundation

@propertyWrapper
public struct Injected<Service, Container: DIContainer> {
    private let component: Service

    public init(_ container: Container) {
        self.component = container.resolve()
    }

    public var wrappedValue: Service {
        return component
    }
}
