//
//  Rx+extractData.swift
//  Kidsnote_Pre_Project
//
//  Created by 김상혁 on 2023/11/03.
//

import Foundation

import RxSwift

extension ObservableType where Element == NetworkResult {
    func extractData() -> Observable<Data> {
        return flatMap { networkResult -> Observable<Data> in
            guard let data = networkResult.data else {
                return .error(NetworkError.invalidResponseData)
            }
            return .just(data)
        }
    }
}

extension PrimitiveSequence where Trait == SingleTrait, Element == NetworkResult {
    func extractData() -> Single<Data> {
        return asObservable().extractData().asSingle()
    }
}
