//
//  URLSessionURLDataService.swift
//  Kidsnote_Pre_Project
//
//  Created by 김상혁 on 2023/11/07.
//

import Foundation

import RxSwift

final class URLSessionURLDataService: URLDataService {
    
    static let shared = URLSessionURLDataService()
    
    private init() {}
    
    func fetchData(from url: URL) -> Single<Data> {
        return Single<Data>.create { single in
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    single(.failure(NetworkError.errorDetected(error: error)))
                } else if let data = data {
                    single(.success(data))
                } else {
                    single(.failure(NetworkError.invalidResponseData))
                }
            }
            
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
}
