//
//  Reactive+UIImage.swift
//  Kidsnote_Pre_Project
//
//  Created by 김상혁 on 2023/11/07.
//

import RxCocoa
import RxSwift

extension ObservableType where Element == UIImage? {
    func catchErrorReturnImage(
        invalidURLErrorImage: UIImage?,
        otherErrorImage: UIImage? = ImageAsset.exclamationmarkTriangle
    ) -> Observable<Element> {
        return self.catch { error -> Observable<Element> in
            if let error = error as? NetworkError, case .invalidURL = error {
                return .just(invalidURLErrorImage)
            }
            return .just(otherErrorImage)
        }
    }
}
