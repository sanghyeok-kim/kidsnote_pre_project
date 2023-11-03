//
//  Rx+logErrorIfDetected.swift
//  Kidsnote_Pre_Project
//
//  Created by 김상혁 on 2023/11/03.
//

import Foundation
import OSLog

import RxSwift

public extension ObservableType {
    func logErrorIfDetected(category: OSLog.LogCategory, type: OSLogType = .error) -> Observable<Element> {
        return self.do(onError: { error in
            let errorMessage = error.localizedDescription
            Logger.log(message: errorMessage, category: category, type: type)
        })
    }
}

public extension PrimitiveSequence where Trait == SingleTrait {
    func logErrorIfDetected(category: OSLog.LogCategory, type: OSLogType = .error) -> Single<Element> {
        return self.asObservable()
            .logErrorIfDetected(category: category, type: type)
            .asSingle()
    }
}

public extension PrimitiveSequence where Trait == CompletableTrait, Element == Never {
    func logErrorIfDetected(category: OSLog.LogCategory, type: OSLogType = .error) -> Completable {
        return self.asObservable()
            .logErrorIfDetected(category: category, type: type)
            .asCompletable()
    }
}
