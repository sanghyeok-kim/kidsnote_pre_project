//
//  Rx+decodeJsonStringMap.swift
//  Kidsnote_Pre_Project
//
//  Created by 김상혁 on 2023/11/10.
//

import Foundation

import RxSwift

extension ObservableType where Element == Data {
    func decodeJsonStringMap<T: Decodable>(_ type: T.Type) -> Observable<T> {
        return flatMap { data -> Observable<T> in
            let responseString = String(data: data, encoding: .utf8) ?? ""
            let trimmedString = responseString.trimmingCharacters(in: CharacterSet(charactersIn: ";"))
            
            guard let jsonData = trimmedString.data(using: .utf8) else {
                throw NetworkError.invalidResponseData
            }
            
            do {
                let decodedObject = try JSONDecoder().decode(T.self, from: jsonData)
                return .just(decodedObject)
            } catch {
                throw NetworkError.decodeError
            }
        }
    }
}

extension PrimitiveSequence where Trait == SingleTrait, Element == Data {
    func decodeJsonStringMap<T: Decodable>(_ type: T.Type) -> Single<T> {
        return asObservable().decodeJsonStringMap(type).asSingle()
    }
}
