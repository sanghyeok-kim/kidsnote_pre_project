//
//  Reactive+BookTypeSegmentControl.swift
//  Kidsnote_Pre_Project
//
//  Created by 김상혁 on 2023/11/07.
//

import RxSwift
import RxCocoa

extension Reactive where Base == BookTypeSegmentControl {
    var selectedSegmentIndex: ControlEvent<Int> {
        let source: Observable<Int> = self.base.rx.controlEvent(.valueChanged)
            .map { base.selectedSegmentIndex }
            .compactMap { $0 }
        return ControlEvent(events: source)
    }
}
