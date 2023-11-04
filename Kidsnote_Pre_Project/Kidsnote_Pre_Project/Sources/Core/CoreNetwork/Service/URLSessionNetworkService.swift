//
//  URLSessionNetworkService.swift
//  Kidsnote_Pre_Project
//
//  Created by 김상혁 on 2023/11/03.
//

import Foundation

import RxSwift

final class URLSessionNetworkService: NetworkService {
    
    static let shared = URLSessionNetworkService()
    
    private init() {}
    
    func fetchNetworkResult<E: Encodable>(target: TargetType, with bodyObject: E) -> Single<NetworkResult> {
        return performRequest(target: target, bodyObject: bodyObject)
    }
    
    func fetchData<E: Encodable>(target: TargetType, with bodyObject: E) -> Single<Data> {
        return performRequest(target: target, bodyObject: bodyObject)
            .validateStatusCode()
            .extractData()
    }
    
    func fetchStatusCode<E: Encodable>(target: TargetType, with bodyObject: E) -> Single<Int> {
        return performRequest(target: target, bodyObject: bodyObject)
            .map { $0.statusCode }
    }
}

// MARK: - HTTP Request Performing Methods

private extension URLSessionNetworkService {
    func performRequest<E: Encodable>(target: TargetType, bodyObject: E) -> Single<NetworkResult> {
        return Single.create { [weak self] single -> Disposable in
            guard let self = self else {
                single(.failure(NetworkError.objectDeallocated))
                return Disposables.create()
            }
            
            let request: URLRequest
            
            do {
                request = try self.buildRequest(from: target, with: bodyObject)
            } catch {
                single(.failure(NetworkError.invalidRequest))
                return Disposables.create()
            }
            
            return self.performDataTask(with: request)
                .subscribe(onSuccess: { result in
                    single(.success(result))
                }, onFailure: { error in
                    single(.failure(error))
                })
        }
    }
    
    // MARK: - Supporting Methods for performRequest(target:bodyObject:)
    
    func performDataTask(with request: URLRequest) -> Single<NetworkResult> {
        return Single.create { single -> Disposable in
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    single(.failure(NetworkError.errorDetected(error: error)))
                    return
                }
                
                guard let response = response as? HTTPURLResponse else {
                    single(.failure(NetworkError.invalidResponse))
                    return
                }
                
                single(.success(NetworkResult(data: data, response: response)))
            }
            
            task.resume()
            
            return Disposables.create { task.cancel() }
        }
    }
}

// MARK: - Supporting Methods

private extension URLSessionNetworkService {
    func buildRequest<E: Encodable>(from target: TargetType, with bodyObject: E) throws -> URLRequest {
        let urlComponents = try configureURLComponents(from: target)
        var request = try configureURLRequest(from: urlComponents, with: target)
        request = try configureRequestBody(from: request, with: bodyObject)
        return request
    }
    
    // MARK: - Supporting Methods for buildRequest(from:with:)
    
    func configureURLComponents(from target: TargetType) throws -> URLComponents {
        guard let url = target.baseURL?.appendingPathComponent(target.path),
              var urlComponents = URLComponents(string: url.absoluteString) else {
            throw NetworkError.invalidURL
        }
        
        if let parameters = target.parameters {
            urlComponents.queryItems = parameters.map {
                URLQueryItem(name: $0.key, value: String(describing: $0.value))
            }
        }
        
        return urlComponents
    }
    
    func configureURLRequest(from urlComponents: URLComponents, with target: TargetType) throws -> URLRequest {
        guard let finalUrl = urlComponents.url else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(
            url: finalUrl,
            cachePolicy: .reloadRevalidatingCacheData,
            timeoutInterval: 30.0
        )
        request.httpMethod = target.method.value
        
        if let headers = target.headers {
            for (key, value) in headers {
                request.addValue(value, forHTTPHeaderField: key)
            }
        }
        
        return request
    }
    
    func configureRequestBody<E: Encodable>(from request: URLRequest, with bodyObject: E) throws -> URLRequest {
        var request = request
        guard !(bodyObject is EmptyBody) else { return request }
        
        let encoder = JSONEncoder()
        do {
            request.httpBody = try encoder.encode(bodyObject)
        } catch {
            throw NetworkError.encodeError
        }
        
        return request
    }
}
