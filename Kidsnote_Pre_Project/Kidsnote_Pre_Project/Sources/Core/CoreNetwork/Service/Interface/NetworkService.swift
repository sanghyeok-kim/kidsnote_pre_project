//
//  NetworkService.swift
//  Kidsnote_Pre_Project
//
//  Created by 김상혁 on 2023/11/03.
//

import Foundation

import RxSwift

protocol NetworkService {
    func fetchNetworkResult<E: Encodable>(target: TargetType, with bodyObject: E) -> Single<NetworkResult>
    func fetchData<E: Encodable>(target: TargetType, with bodyObject: E) -> Single<Data>
    func fetchStatusCode<E: Encodable>(target: TargetType, with bodyObject: E) -> Single<Int>
}

extension NetworkService {
    func fetchNetworkResult(target: TargetType) -> Single<NetworkResult> {
        fetchNetworkResult(target: target, with: EmptyBody())
    }
    
    func fetchData(target: TargetType) -> Single<Data> {
        fetchData(target: target, with: EmptyBody())
    }

    func fetchStatusCode(target: TargetType) -> Single<Int> {
        fetchStatusCode(target: target, with: EmptyBody())
    }
}
