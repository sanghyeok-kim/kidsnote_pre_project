//
//  Reactive+UIImageView.swift
//  Kidsnote_Pre_Project
//
//  Created by 김상혁 on 2023/11/07.
//

import RxCocoa
import RxSwift

extension Reactive where Base: UIImageView {
    var resizedWidthImage: Binder<UIImage?> {
        return Binder(self.base) { imageView, image in
            imageView.image = image?.resizeAspectFit(width: imageView.frame.width)
        }
    }
}
