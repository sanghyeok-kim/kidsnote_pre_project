//
//  Rx+transformMap.swift
//  Kidsnote_Pre_Project
//
//  Created by 김상혁 on 2023/11/03.
//

import Foundation

import RxSwift

// MARK: - For Non-Sequence Element

extension ObservableType {
    func transformMap<T: DataMapper>(_ mapper: T) -> Observable<T.Output> where Element == T.Input {
        return map { element in
            return try mapper.transform(element)
        }
    }
}

extension PrimitiveSequence where Trait == SingleTrait {
    func transformMap<T: DataMapper>(_ mapper: T) -> Single<T.Output> where Element == T.Input {
        return asObservable().transformMap(mapper).asSingle()
    }
}

// MARK: - For Sequence Element

extension ObservableType where Element: Sequence {
    func transformMap<T: DataMapper>(_ mapper: T) -> Observable<[T.Output]> where Element.Element == T.Input {
        return map { sequenceElement in
            return try sequenceElement.map { try mapper.transform($0) }
        }
    }
}

extension PrimitiveSequence where Trait == SingleTrait {
    func transformMap<T: DataMapper>(_ mapper: T) -> Single<[T.Output]> where Element == [T.Input] {
        return asObservable().transformMap(mapper).asSingle()
    }
}
