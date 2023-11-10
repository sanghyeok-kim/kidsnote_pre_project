//
//  Reactive+TapInteractiveView.swift
//  Kidsnote_Pre_Project
//
//  Created by 김상혁 on 2023/11/10.
//

import RxSwift
import RxCocoa

extension Reactive where Base: TapInteractiveView {
    var tap: ControlEvent<Void> {
        return controlEvent(.touchUpInside)
    }
}

