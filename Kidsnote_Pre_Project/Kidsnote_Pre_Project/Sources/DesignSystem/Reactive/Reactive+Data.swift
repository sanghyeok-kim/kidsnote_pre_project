//
//  Reactive+Data.swift
//  Kidsnote_Pre_Project
//
//  Created by 김상혁 on 2023/11/07.
//

import RxSwift

extension ObservableType where Element == Data {
    func transformToUIImage() -> Observable<UIImage?> {
        return self.observe(on: ConcurrentDispatchQueueScheduler(qos: .userInitiated))
            .map { data in
                return UIImage(data: data)
            }
            .observe(on: MainScheduler.instance)
    }
}
