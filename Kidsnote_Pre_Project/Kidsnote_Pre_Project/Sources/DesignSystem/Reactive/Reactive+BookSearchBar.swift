//
//  Reactive+BookSearchBar.swift
//  Kidsnote_Pre_Project
//
//  Created by 김상혁 on 2023/11/05.
//

import Foundation

import RxCocoa
import RxSwift

extension Reactive where Base: BookSearchBar {
    var tap: ControlEvent<Void> {
        return base.tapButton.rx.tap
    }
}
